#!/usr/bin/env python3
"""Record a no-network HW06 execution preflight blocked by missing studentId."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
PREFLIGHT_ID = "preflight-001"
TIMESTAMP = "2026-08-21 20:32:37 +07:00"
BLOCKER = "STUDENT_ID_NOT_CONFIGURED"

INPUTS = [
    "postman/collections/HW06-API-Testing.postman_collection.json",
    "postman/environments/HW06-Local.postman_environment.json",
    "postman/data/api-01-reset-password.json",
    "postman/data/api-02-checkout.json",
    "postman/data/api-03-import-products.json",
    "docs/postman/execution-manifest.md",
    "docs/postman/external-verification-plan.md",
]

API_FILES = {
    "API-01": "api-01-reset-password.json",
    "API-02": "api-02-checkout.json",
    "API-03": "api-03-import-products.json",
}


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def write_text(path: Path, content: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content.rstrip() + "\n", encoding="utf-8")


def write_json(path: Path, content):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(content, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def sha256(path: Path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def main():
    per_api = {}
    all_rows = []
    for api_id, filename in API_FILES.items():
        inventory = read_json(ROOT / "test-cases" / "final" / filename)
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

        slug = filename.removesuffix(".json")
        lines = [
            f"# {api_id} Blocked Execution Preflight",
            "",
            f"Preflight ID: `{PREFLIGHT_ID}`  ",
            f"Timestamp: `{TIMESTAMP}`  ",
            "Execution status: `BLOCKED`  ",
            f"Blocker: `{BLOCKER}`  ",
            "Real requests sent: `0`",
            "",
            "The mandatory `studentId` environment variable exists but is empty. Per the approved execution guard, no SUT request, backend startup, smoke run, or Newman run was allowed. This is not product-failure evidence.",
            "",
            "## Counts",
            "",
            f"- TOTAL_EXECUTABLE: `{len(rows)}`",
            "- PASS: `0`",
            "- FAIL: `0`",
            "- POSTMAN_PASS_EXTERNAL_PENDING: `0`",
            f"- BLOCKED: `{len(rows)}`",
            "- NOT_RUN: `0`",
            "- PRODUCT_DEFECT_CANDIDATE: `0`",
            "- TEST_DEFECT: `0`",
            "- TEST_DATA_DEFECT: `0`",
            f"- ENVIRONMENT_DEFECT: `{len(rows)}`",
            "- SPEC_AMBIGUITY: `0`",
            "- EXTERNAL_VERIFICATION_PENDING: `0`",
            "- NEEDS_HUMAN_REVIEW: `0`",
            "",
            "## Case accounting",
            "",
            "| CASE_ID | SOURCE | EXECUTION_MODE | RUNTIME_STATUS | PRELIMINARY_CLASSIFICATION | REASON | REQUEST_SENT |",
            "| --- | --- | --- | --- | --- | --- | --- |",
        ]
        for row in rows:
            lines.append("| {case_id} | {source} | {execution_mode} | {runtime_status} | {preliminary_classification} | {reason} | NO |".format(**row))
        write_text(ROOT / "docs" / "execution-results" / f"{slug}-execution.md", "\n".join(lines))

    external_planned = sum(row["execution_mode"] == "POSTMAN_PLUS_EXTERNAL_VERIFICATION" for row in all_rows)
    summary = {
        "preflight_id": PREFLIGHT_ID,
        "timestamp": TIMESTAMP,
        "execution_status": "BLOCKED",
        "blockers": [
            "STUDENT_ID_NOT_CONFIGURED",
            "REQUIRED_DISPOSABLE_CREDENTIALS_NOT_CONFIGURED",
            "NEWMAN_UNAVAILABLE",
            "SUT_NOT_RUNNING",
        ],
        "student_id": {"present": True, "non_empty": False, "value_logged": False},
        "tools": {"node": "v22.18.0", "npm": "10.9.3", "newman": "UNAVAILABLE"},
        "sut": {
            "base_url": "http://localhost:3000",
            "listener_before_execution": False,
            "started": False,
            "request_sent": False,
            "database": "../eshop-sut/backend/database.sqlite",
            "environment_kind": "local homework SUT",
        },
        "smoke": "BLOCKED",
        "full_execution": "NOT_RUN",
        "newman_started": False,
        "results": {
            "total": len(all_rows),
            "pass": 0,
            "fail": 0,
            "postman_pass_external_pending": 0,
            "blocked": len(all_rows),
            "not_run": 0,
        },
        "preliminary_classification": {
            "product_defect_candidate": 0,
            "test_defect": 0,
            "test_data_defect": 0,
            "environment_defect": len(all_rows),
            "spec_ambiguity": 0,
            "external_verification_pending": 0,
            "needs_human_review": 0,
        },
        "external_verification": {"planned": external_planned, "completed": 0, "passed": 0, "failed": 0, "pending": external_planned},
        "per_api": {
            api_id: {"total": len(rows), "pass": 0, "fail": 0, "postman_pass_external_pending": 0, "blocked": len(rows), "not_run": 0}
            for api_id, rows in per_api.items()
        },
        "approved_input_hashes_sha256": {relative: sha256(ROOT / relative) for relative in INPUTS},
        "cases": {api_id: rows for api_id, rows in per_api.items()},
    }
    write_json(ROOT / "test-results" / "hw06" / PREFLIGHT_ID / "preflight.json", summary)

    metadata = [
        "# HW06 Execution Preflight Metadata",
        "",
        f"- PREFLIGHT_ID: `{PREFLIGHT_ID}`",
        f"- TIMESTAMP: `{TIMESTAMP}`",
        "- STATUS: `BLOCKED`",
        f"- PRIMARY_BLOCKER: `{BLOCKER}`",
        "- BASE_URL: `http://localhost:3000`",
        "- STUDENT_ID_PRESENT: `YES`",
        "- STUDENT_ID_NON_EMPTY: `NO`",
        "- STUDENT_ID_VALUE_LOGGED: `NO`",
        "- NODE_VERSION: `v22.18.0`",
        "- NPM_VERSION: `10.9.3`",
        "- NEWMAN_VERSION: `UNAVAILABLE`",
        "- PORT_3000_LISTENER: `NO`",
        "- SUT_STARTED: `NO`",
        "- SMOKE: `BLOCKED`",
        "- FULL_EXECUTION: `NOT_RUN`",
        "- REAL_REQUESTS_EXECUTED: `NO`",
        "- NEWMAN_STARTED: `NO`",
        "",
        "## Local commands invoked",
        "",
        "```text",
        "python postman\\scripts\\validate-static.py",
        "node --version",
        "npm.cmd --version",
        "Get-Command newman.cmd,newman",
        "Get-NetTCPConnection -LocalPort 3000 -State Listen",
        "Get-FileHash <approved inputs> -Algorithm SHA256",
        "```",
        "",
        "No HTTP client, SUT startup command, Postman Runner, Newman command, package installation, database write, or external verifier was invoked.",
        "",
        "## Approved input hashes (SHA-256)",
        "",
    ]
    for relative, digest in summary["approved_input_hashes_sha256"].items():
        metadata.append(f"- `{digest}` — `{relative}`")
    write_text(ROOT / "test-results" / "hw06" / PREFLIGHT_ID / "execution-metadata.md", "\n".join(metadata))

    cross = [
        "# HW06 Cross-API Execution Summary",
        "",
        f"Preflight ID: `{PREFLIGHT_ID}`  ",
        f"Timestamp: `{TIMESTAMP}`  ",
        "HW06 real API execution: `BLOCKED`  ",
        f"Primary blocker: `{BLOCKER}`",
        "",
        "No assignment request was sent. All 93 final testcase identities are accounted as `BLOCKED / ENVIRONMENT_DEFECT`; none is a runtime FAIL or product defect candidate.",
        "",
        "| API | TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |",
        "| --- | ---: | ---: | ---: | ---: | ---: | ---: |",
        "| API-01 | 30 | 0 | 0 | 0 | 30 | 0 |",
        "| API-02 | 30 | 0 | 0 | 0 | 30 | 0 |",
        "| API-03 | 33 | 0 | 0 | 0 | 33 | 0 |",
        "| **Total** | **93** | **0** | **0** | **0** | **93** | **0** |",
        "",
        "## Preliminary failure classification",
        "",
        "| Classification | Count |",
        "| --- | ---: |",
        "| PRODUCT_DEFECT_CANDIDATE | 0 |",
        "| TEST_DEFECT | 0 |",
        "| TEST_DATA_DEFECT | 0 |",
        "| ENVIRONMENT_DEFECT | 93 |",
        "| SPEC_AMBIGUITY | 0 |",
        "| EXTERNAL_VERIFICATION_PENDING | 0 |",
        "| NEEDS_HUMAN_REVIEW | 0 |",
        "",
        "## External verification",
        "",
        f"Planned: `{external_planned}`; completed: `0`; passed: `0`; failed: `0`; pending: `{external_planned}`. External work did not begin because the mandatory request guard blocked smoke execution.",
        "",
        "## Resume requirements",
        "",
        "Configure a non-empty student ID and disposable fixture credentials in the local Postman environment without committing or printing their values. Re-run preflight before installing/using Newman or starting the local backend.",
    ]
    write_text(ROOT / "docs" / "execution-results" / "cross-api-execution-summary.md", "\n".join(cross))

    print(json.dumps({"status": "BLOCKED", "total": len(all_rows), "blocked": len(all_rows), "external_planned": external_planned}, indent=2))


if __name__ == "__main__":
    main()
