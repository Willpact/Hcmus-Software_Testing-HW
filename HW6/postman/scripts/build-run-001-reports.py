#!/usr/bin/env python3
"""Build HW06 run-001 reports from verified case-accounting evidence."""

from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
RUN = ROOT / "test-results" / "hw06" / "run-001"
DOCS = ROOT / "docs" / "execution-results"
FINAL_FILES = {
    "API-01": ROOT / "test-cases" / "final" / "api-01-reset-password.json",
    "API-02": ROOT / "test-cases" / "final" / "api-02-checkout.json",
    "API-03": ROOT / "test-cases" / "final" / "api-03-import-products.json",
}
REPORT_FILES = {
    "API-01": "api-01-reset-password-execution.md",
    "API-02": "api-02-checkout-execution.md",
    "API-03": "api-03-import-products-execution.md",
}


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def write(path: Path, value: str):
    path.write_text(value.rstrip() + "\n", encoding="utf-8")


accounting = load(RUN / "case-accounting.json")
summary = accounting["summary"]
records = {row["case_id"]: row for row in accounting["cases"]}
external = {
    row["case_id"]: row
    for row in load(RUN / "external-verification-results.json")["cases"]
}
final = {
    case["case_id"]: case
    for file in FINAL_FILES.values()
    for case in load(file)["cases"]
}

common_history = """## Execution history

- `preflight-001 — PRESERVED`: configuration guard stopped before any request; historical `PRE_EXECUTION_BLOCKED: 93`, runtime defects `0`.
- `preflight-002 — PRESERVED`: local Newman tooling unavailable; historical `PRE_EXECUTION_BLOCKED: 93`, runtime defects `0`.
- `preflight-003 — PASS`: Student ID non-empty, credentials ready, Newman `6.2.2`, htmlextra `1.23.1`, 103/103 static header coverage, safe isolated SQLite strategy.
- `smoke-001 — FAIL / HARNESS_DEFECT`: 11 real requests; duplicate setup-script variable identifier prevented OTP/token assignment; evidence preserved.
- `smoke-002 — PASS_FOR_FULL_EXECUTION_GATE_WITH_PRODUCT_DEFECT_CANDIDATES`: 11 main requests plus one cart postcheck; 12/12 runtime header coverage.
- `run-001 — COMPLETED`: 103 collection requests plus two read-only cart postchecks; 93 stable testcase identities; no data file and no multiplication.
"""

for api_id, report_name in REPORT_FILES.items():
    counts = summary["results"]["per_api"][api_id]
    rows = [records[case_id] for case_id in sorted(records) if records[case_id]["api_id"] == api_id]
    lines = [
        f"# {api_id} Real Execution Report",
        "",
        common_history.rstrip(),
        "",
        "## run-001 accounting",
        "",
        "| TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |",
        "| ---: | ---: | ---: | ---: | ---: | ---: |",
        f"| {counts['total']} | {counts['pass']} | {counts['fail']} | {counts['postman_pass_external_pending']} | {counts['blocked']} | {counts['not_run']} |",
        "",
        "Newman exit `0` is retained as runner evidence, not promoted to business PASS without an implemented or external oracle. No final product defect is declared.",
        "",
        "## Case accounting",
        "",
        "| CASE_ID | SOURCE | HTTP | RESULT | PRELIMINARY_CLASSIFICATION | EXTERNAL | REASON |",
        "| --- | --- | ---: | --- | --- | --- | --- |",
    ]
    for row in rows:
        external_status = external.get(row["case_id"], {}).get("status", "NOT_PLANNED")
        reason = row["reason"].replace("|", "\\|")
        lines.append(
            f"| {row['case_id']} | {row['source']} | {row['observed_status_code']} | {row['result']} | "
            f"{row['preliminary_classification']} | {external_status} | {reason} |"
        )
    lines += [
        "",
        "## Evidence",
        "",
        "- `test-results/hw06/run-001/newman.json`",
        "- `test-results/hw06/run-001/newman.html`",
        "- `test-results/hw06/run-001/stdout.log`",
        "- `test-results/hw06/run-001/stderr.log`",
        "- `test-results/hw06/run-001/execution-metadata.md`",
        "- `test-results/hw06/run-001/case-accounting.json`",
        "- `test-results/hw06/run-001/external-verification-results.json`",
    ]
    write(DOCS / report_name, "\n".join(lines))

total = summary["results"]["total"]
classifications = summary["preliminary_classification"]
ext = summary["external_verification"]
cross = f"""# HW06 Cross-API Real Execution Summary

{common_history}

## Final testcase accounting from run-001

| API | TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| API-01 | 30 | 9 | 0 | 1 | 20 | 0 |
| API-02 | 30 | 3 | 24 | 0 | 3 | 0 |
| API-03 | 33 | 15 | 14 | 0 | 4 | 0 |
| **Total** | **{total['total']}** | **{total['pass']}** | **{total['fail']}** | **{total['postman_pass_external_pending']}** | **{total['blocked']}** | **{total['not_run']}** |

## External verification

| PLANNED | COMPLETED | PASSED | FAILED | PENDING | BLOCKED |
| ---: | ---: | ---: | ---: | ---: | ---: |
| {ext['planned']} | {ext['completed']} | {ext['passed']} | {ext['failed']} | {ext['pending']} | {ext['blocked']} |

## Preliminary classification

| Classification | Count |
| --- | ---: |
| PRODUCT_DEFECT_CANDIDATE | {classifications['product_defect_candidate']} |
| TEST_DEFECT | {classifications['test_defect']} |
| TEST_DATA_DEFECT | {classifications['test_data_defect']} |
| ENVIRONMENT_DEFECT | {classifications['environment_defect']} |
| SPEC_AMBIGUITY | {classifications['spec_ambiguity']} |
| EXTERNAL_VERIFICATION_PENDING | {classifications['external_verification_pending']} |
| NEEDS_HUMAN_REVIEW | {classifications['needs_human_review']} |

`PRODUCT_DEFECT_FINAL: 0`. All 38 product findings remain candidates pending Human Failure Triage.

## Runtime request/header accounting

- Smoke and smoke postcheck requests: `23/23` with resolved non-empty `X-Student-Id`.
- Full run and full postcheck requests: `105/105` with resolved non-empty `X-Student-Id`.
- Total real SUT requests: `128`.
- Total runtime header coverage: `128/128`.
- Missing or empty: `[]`.

## Evidence boundary

The machine-generated Newman report has zero script/assertion failures. The generated case scripts assert the runtime Student-ID guard and response capture, so Newman green is not treated as 93 business PASS. Case outcomes use approved business/state oracles, actual response/state evidence, and conservative blocking where fixtures or multi-step setup were not valid.

## Next checkpoint

`HW06_EXECUTION_FAILURE_TRIAGE_REQUIRED`
"""
write(DOCS / "cross-api-execution-summary.md", cross)

triage = [
    "# HW06 Failure Triage Packet",
    "",
    "All entries are preliminary. `HUMAN_DECISION: PENDING`; no GitHub Issue or final product defect is created.",
]
for case_id in sorted(records):
    row = records[case_id]
    if row["result"] == "PASS":
        continue
    case = final[case_id]
    test_case = case["test_case"]
    ext_row = external.get(case_id)
    ext_status = ext_row["status"] if ext_row else "NOT_PLANNED"
    triage += [
        "",
        f"## {case_id}",
        "",
        f"- CASE_ID: `{case_id}`",
        f"- API: `{row['api_id']}`",
        f"- SOURCE: `{row['source']}`",
        f"- REQUIREMENT: `{', '.join(test_case['requirement_ids'])}`",
        f"- ORACLE: {test_case['expected_business_result']} State: {test_case['expected_state']}",
        f"- SETUP: {'; '.join(case['setup_requirements'])}",
        f"- REQUEST SUMMARY: `{test_case['endpoint']}`; {test_case['request'].get('body_variation', 'approved request sequence')}",
        f"- OBSERVED RESULT: HTTP `{row['observed_status_code']}`; case result `{row['result']}`.",
        f"- EXPECTED INVARIANT: {test_case['expected_business_result']} {test_case['expected_state']}",
        "- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.",
        f"- EXTERNAL VERIFICATION: `{ext_status}`",
        f"- PRELIMINARY CLASSIFICATION: `{row['preliminary_classification']}`",
        "- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`",
        "",
        "HUMAN_DECISION:",
        "PENDING",
    ]
write(DOCS / "failure-triage-packet.md", "\n".join(triage))

print(json.dumps({
    "status": "REPORTS_BUILT",
    "api_reports": 3,
    "case_rows": len(records),
    "triage_entries": sum(1 for row in records.values() if row["result"] != "PASS"),
    "cross_total": total,
}, indent=2))
