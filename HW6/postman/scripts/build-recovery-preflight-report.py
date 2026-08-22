#!/usr/bin/env python3
"""Record preflight-002 without overwriting preflight-001 or fabricating execution."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
PREFLIGHT_ID = "preflight-002"
TIMESTAMP = "2026-08-21 20:46:43 +07:00"
BLOCKER = "NEWMAN_LOCAL_INSTALL_UNAVAILABLE_IN_CURRENT_SANDBOX"
API_FILES = {
    "API-01": "api-01-reset-password.json",
    "API-02": "api-02-checkout.json",
    "API-03": "api-03-import-products.json",
}


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def write_json(path: Path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def write_text(path: Path, value: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(value.rstrip() + "\n", encoding="utf-8")


def digest(path: Path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def main():
    previous = ROOT / "test-results" / "hw06" / "preflight-001"
    if not (previous / "preflight.json").exists() or not (previous / "execution-metadata.md").exists():
        raise RuntimeError("preflight-001 evidence is missing")
    runtime_meta = load(ROOT / "test-results" / "hw06" / "runtime" / "runtime-configuration-metadata.json")
    all_rows = []
    per_api = {}
    for api_id, filename in API_FILES.items():
        inventory = load(ROOT / "test-cases" / "final" / filename)
        rows = []
        for record in inventory["cases"]:
            row = {
                "case_id": record["case_id"],
                "source": record["source"],
                "execution_mode": record["execution_mode"],
                "runtime_status": "BLOCKED",
                "preliminary_classification": "ENVIRONMENT_DEFECT",
                "reason": BLOCKER,
                "request_sent": False,
            }
            rows.append(row)
            all_rows.append(row)
        per_api[api_id] = rows

    external_planned = sum(row["execution_mode"] == "POSTMAN_PLUS_EXTERNAL_VERIFICATION" for row in all_rows)
    evidence = {
        "preflight_id": PREFLIGHT_ID,
        "timestamp": TIMESTAMP,
        "previous_preflight": {
            "id": "preflight-001",
            "preserved": True,
            "preflight_json_sha256": digest(previous / "preflight.json"),
            "metadata_sha256": digest(previous / "execution-metadata.md"),
        },
        "execution_recovery_status": "BLOCKED",
        "student_id": {
            "configured": True,
            "value_logged": False,
            "sources": runtime_meta["student_id_sources"],
            "sources_agree": runtime_meta["sources_agree"],
        },
        "credentials": {
            "normal_user": "READY_FROM_SEED",
            "second_user": "READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT",
            "admin": "READY_FROM_SEED",
            "reset_user": "READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT",
            "secrets_logged": False,
        },
        "runtime_environment": {
            "path": runtime_meta["runtime_environment"],
            "intended_for_commit": False,
            "all_mandatory_values_non_empty": True,
        },
        "tools": {
            "node": "v22.18.0",
            "npm": "10.9.3",
            "newman": "UNAVAILABLE",
            "html_reporter": "UNAVAILABLE",
            "newman_existing_local_or_global": False,
            "offline_install": "FAILED_ENOTCACHED",
            "registry_install": "FAILED_EACCES_NETWORK_PERMISSION",
        },
        "sut": {
            "status": "PREPARED_NOT_STARTED",
            "server_syntax": "PASS",
            "dependencies": "PASS",
            "start_command": "node server.js",
            "base_url": "http://localhost:3000",
            "database_type": "SQLite",
            "database_path": "../eshop-sut/backend/database.sqlite",
            "local_test_environment_confirmed": True,
            "requests_sent": 0,
        },
        "smoke": {"run_id": "NONE", "status": "BLOCKED", "harness_corrections": []},
        "full_execution": {"run": False, "run_id": "NONE"},
        "results": {"total": 93, "pass": 0, "fail": 0, "postman_pass_external_pending": 0, "blocked": 93, "not_run": 0},
        "external_verification": {"planned": external_planned, "completed": 0, "passed": 0, "failed": 0, "pending": 0, "blocked": external_planned},
        "preliminary_classification": {
            "product_defect_candidate": 0,
            "test_defect": 0,
            "test_data_defect": 0,
            "environment_defect": 93,
            "spec_ambiguity": 0,
            "external_verification_pending": 0,
            "needs_human_review": 0,
        },
        "blockers": [BLOCKER, "HTML_REPORTER_UNAVAILABLE"],
        "cases": per_api,
    }
    out = ROOT / "test-results" / "hw06" / PREFLIGHT_ID
    write_json(out / "preflight.json", evidence)

    metadata = [
        "# HW06 Recovery Preflight Metadata",
        "",
        f"- PREFLIGHT_ID: `{PREFLIGHT_ID}`",
        f"- TIMESTAMP: `{TIMESTAMP}`",
        "- PREVIOUS_PREFLIGHT: `preflight-001 — PRESERVED`",
        "- STUDENT_ID_CONFIGURED: `YES`",
        "- STUDENT_ID_VALUE_LOGGED: `NO`",
        "- CREDENTIAL_STRATEGY: `READY`",
        "- RUNTIME_ENVIRONMENT: `test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json`",
        "- RUNTIME_ENVIRONMENT_INTENDED_FOR_COMMIT: `NO`",
        "- NODE_VERSION: `v22.18.0`",
        "- NPM_VERSION: `10.9.3`",
        "- NEWMAN_VERSION: `UNAVAILABLE`",
        "- HTML_REPORTER: `UNAVAILABLE`",
        "- SUT_STATUS: `PREPARED_NOT_STARTED`",
        "- SUT_START_COMMAND: `node server.js`",
        "- DATABASE: `SQLite — ../eshop-sut/backend/database.sqlite`",
        "- REAL_REQUESTS_EXECUTED: `NO`",
        "- PRIMARY_BLOCKER: `NEWMAN_LOCAL_INSTALL_UNAVAILABLE_IN_CURRENT_SANDBOX`",
        "",
        "## Trusted configuration sources",
        "",
    ]
    metadata.extend(f"- `{source}`" for source in runtime_meta["student_id_sources"])
    metadata += [
        "",
        "All trusted sources contained one identical explicit Student ID. The value is intentionally omitted.",
        "",
        "## Newman resolution evidence",
        "",
        "- Existing local/global Newman search: not found.",
        "- Offline local installation: failed with `ENOTCACHED`; cache lacked required metadata/dependency responses.",
        "- Registry local installation: failed with `EACCES` under the current network/permission sandbox.",
        "- No package was represented as installed; no Newman version or HTML report was fabricated.",
        "",
        "## SUT preparation",
        "",
        "`server.js` passed `node --check`; Express/CORS/body-parser/JWT/SQLite dependencies resolve from the backend installation. The backend was not started because Newman remained a mandatory blocker, and zero requests were sent.",
    ]
    write_text(out / "execution-metadata.md", "\n".join(metadata))

    for api_id, filename in API_FILES.items():
        rows = per_api[api_id]
        slug = filename.removesuffix(".json")
        lines = [
            f"# {api_id} Execution Status",
            "",
            "## Previous blocked preflight",
            "",
            "`preflight-001` is preserved under `test-results/hw06/preflight-001/`. It was blocked by missing runtime identity/credentials before any request.",
            "",
            "## Current recovery preflight",
            "",
            f"- ID: `{PREFLIGHT_ID}`",
            "- Student ID: `CONFIGURED` from trusted repository-local homework metadata; value not logged.",
            "- Credentials: seed/registration strategy ready; secrets not logged.",
            "- Newman: `UNAVAILABLE` after one offline and one registry-local install attempt.",
            "- SUT: `PREPARED_NOT_STARTED`.",
            "- Real requests: `0`.",
            "",
            "| TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |",
            "| ---: | ---: | ---: | ---: | ---: | ---: |",
            f"| {len(rows)} | 0 | 0 | 0 | {len(rows)} | 0 |",
            "",
            "## Case accounting",
            "",
            "| CASE_ID | SOURCE | EXECUTION_MODE | RUNTIME_STATUS | PRELIMINARY_CLASSIFICATION | REASON | REQUEST_SENT |",
            "| --- | --- | --- | --- | --- | --- | --- |",
        ]
        for row in rows:
            lines.append("| {case_id} | {source} | {execution_mode} | {runtime_status} | {preliminary_classification} | {reason} | NO |".format(**row))
        write_text(ROOT / "docs" / "execution-results" / f"{slug}-execution.md", "\n".join(lines))

    cross = """# HW06 Cross-API Execution Summary

## Previous blocked preflight

`preflight-001 — PRESERVED`: configuration guard blocked before any request.

## Recovery preflight

`preflight-002 — BLOCKED`: Student ID and credential strategy were safely recovered; local Newman could not be installed because offline cache was incomplete and registry access was denied by the current sandbox. SUT is prepared but intentionally not started. No request or runtime assertion occurred.

| API | TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| API-01 | 30 | 0 | 0 | 0 | 30 | 0 |
| API-02 | 30 | 0 | 0 | 0 | 30 | 0 |
| API-03 | 33 | 0 | 0 | 0 | 33 | 0 |
| **Total** | **93** | **0** | **0** | **0** | **93** | **0** |

## External verification

Planned: `26`; completed: `0`; passed: `0`; failed: `0`; pending: `0`; blocked: `26`.

## Preliminary classification

`ENVIRONMENT_DEFECT: 93`; every other classification: `0`; `PRODUCT_DEFECT_FINAL: 0`.

## Next action

Provide a runtime with local npm registry access or a preinstalled compatible Newman package (and HTML reporter). Then repeat recovery preflight, start the documented local SUT, register disposable users, and run smoke before any full suite.
"""
    write_text(ROOT / "docs" / "execution-results" / "cross-api-execution-summary.md", cross)
    print(json.dumps({"status": "BLOCKED", "student_id": "CONFIGURED_REDACTED", "credentials": "READY", "newman": "UNAVAILABLE", "sut": "PREPARED_NOT_STARTED", "cases_blocked": 93}, indent=2))


if __name__ == "__main__":
    main()
