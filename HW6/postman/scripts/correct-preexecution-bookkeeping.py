#!/usr/bin/env python3
"""Correct report semantics without changing raw preflight-001/002 evidence."""

from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
API_FILES = {
    "API-01": ("api-01-reset-password.json", 30),
    "API-02": ("api-02-checkout.json", 30),
    "API-03": ("api-03-import-products.json", 33),
}


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def write(path: Path, value: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(value.rstrip() + "\n", encoding="utf-8")


def main():
    previous = ROOT / "test-results" / "hw06"
    if not (previous / "preflight-001" / "preflight.json").exists():
        raise RuntimeError("preflight-001 missing")
    if not (previous / "preflight-002" / "preflight.json").exists():
        raise RuntimeError("preflight-002 missing")

    for api_id, (filename, expected) in API_FILES.items():
        inventory = load(ROOT / "test-cases" / "final" / filename)
        rows = inventory["cases"]
        if len(rows) != expected:
            raise RuntimeError(f"{api_id}: expected {expected}, got {len(rows)}")
        slug = filename.removesuffix(".json")
        lines = [
            f"# {api_id} Pre-execution Status",
            "",
            "## Historical raw evidence",
            "",
            "- `preflight-001`: preserved; blocked before requests because runtime identity/credentials were not configured.",
            "- `preflight-002`: preserved; identity and credential strategy recovered, but Newman remained unavailable.",
            "- Neither preflight executed a testcase or sent a SUT request.",
            "",
            "## Corrected bookkeeping semantics",
            "",
            f"- FINAL_EXECUTABLE_TESTCASES: `{expected}`",
            "- TESTCASES_EXECUTED: `0`",
            f"- PRE_EXECUTION_BLOCKED: `{expected}`",
            "- RUNTIME_ENVIRONMENT_DEFECTS: `0`",
            "- ROOT_BLOCKER_COUNT: `1 tooling category`",
            "- ROOT_BLOCKER: `LOCAL_NEWMAN_TOOLING_UNAVAILABLE`",
            "",
            "The earlier `ENVIRONMENT_DEFECT` per-case wording represented reachability from a blocked preflight, not 93 independently observed runtime defects. No testcase verdict is inferred from the preflight.",
            "",
            "| CASE_ID | SOURCE | EXECUTION_MODE | EXECUTION_STATE | TESTCASE_EXECUTED | RUNTIME_CLASSIFICATION | ROOT_BLOCKER |",
            "| --- | --- | --- | --- | --- | --- | --- |",
        ]
        for record in rows:
            lines.append(
                f"| {record['case_id']} | {record['source']} | {record['execution_mode']} | "
                "PRE_EXECUTION_BLOCKED | NO | NOT_APPLICABLE | LOCAL_NEWMAN_TOOLING_UNAVAILABLE |"
            )
        write(ROOT / "docs" / "execution-results" / f"{slug}-execution.md", "\n".join(lines))

    cross = """# HW06 Cross-API Pre-execution Summary

## Historical raw evidence

`preflight-001` and `preflight-002` are preserved under `test-results/hw06/`. Both stopped before SUT startup/request execution; their raw evidence is not rewritten.

## Corrected bookkeeping semantics

| API | FINAL_EXECUTABLE | TESTCASES_EXECUTED | PRE_EXECUTION_BLOCKED | RUNTIME_ENVIRONMENT_DEFECTS |
| --- | ---: | ---: | ---: | ---: |
| API-01 | 30 | 0 | 30 | 0 |
| API-02 | 30 | 0 | 30 | 0 |
| API-03 | 33 | 0 | 33 | 0 |
| **Total** | **93** | **0** | **93** | **0** |

ROOT_BLOCKER_COUNT: `1 tooling category`  
ROOT_BLOCKER: `LOCAL_NEWMAN_TOOLING_UNAVAILABLE`

No runtime PASS, FAIL, product-defect candidate, test defect, test-data defect, spec ambiguity, or runtime environment defect has been observed because execution has not begun.

External verification: planned `26`; executed `0`; pre-execution blocked `26`.
"""
    write(ROOT / "docs" / "execution-results" / "cross-api-execution-summary.md", cross)
    correction = {
        "status": "REPORTING_SEMANTICS_CORRECTED",
        "raw_preflights_modified": False,
        "final_executable_testcases": 93,
        "testcases_executed": 0,
        "pre_execution_blocked": 93,
        "runtime_environment_defects": 0,
        "root_blocker_count": 1,
        "root_blocker": "LOCAL_NEWMAN_TOOLING_UNAVAILABLE",
    }
    path = ROOT / "docs" / "execution-results" / "preflight-bookkeeping-correction.json"
    path.write_text(json.dumps(correction, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(correction, indent=2))


if __name__ == "__main__":
    main()
