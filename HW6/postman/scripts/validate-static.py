#!/usr/bin/env python3
"""Static-only validation for the HW06 Postman review draft."""

from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
COLLECTION = ROOT / "postman" / "collections" / "HW06-API-Testing.postman_collection.json"
REJECTED = {"API02-STU-004", "API03-STU-005"}
EXPECTED_ENDPOINTS = {
    "API01": ("POST", "/api/reset-password"),
    "API02": ("POST", "/api/checkout"),
    "API03": ("POST", "/api/admin/import-products"),
}


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def leaves(items):
    for item in items:
        if "request" in item:
            yield item
        yield from leaves(item.get("item", []))


def script_text(item):
    return "\n".join(
        line
        for event in item.get("event", [])
        for line in event.get("script", {}).get("exec", [])
    )


def check(condition, label, failures):
    if not condition:
        failures.append(label)


def main():
    failures = []
    collection = load(COLLECTION)
    all_requests = list(leaves(collection["item"]))
    testcase_requests = [item for item in all_requests if item.get("x-case-id")]
    helpers = [item for item in all_requests if item.get("x-helper")]

    final_files = sorted((ROOT / "test-cases" / "final").glob("api-*.json"))
    final_cases = []
    for path in final_files:
        final_cases.extend(load(path)["cases"])
    final_ids = [item["case_id"] for item in final_cases]
    postman_ids = [item["x-case-id"] for item in testcase_requests]

    check(len(final_ids) == 93, f"Final inventory count is {len(final_ids)}, expected 93", failures)
    check(len(postman_ids) == 93, f"Postman identity count is {len(postman_ids)}, expected 93", failures)
    check(len(final_ids) == len(set(final_ids)), "Duplicate final case ID", failures)
    check(len(postman_ids) == len(set(postman_ids)), "Duplicate Postman case ID", failures)
    check(set(final_ids) == set(postman_ids), "Final/Postman identity sets differ", failures)
    check(len({item["name"] for item in all_requests}) == len(all_requests), "Duplicate raw request name", failures)
    check(len(helpers) == 10, f"Setup helper count is {len(helpers)}, expected 10", failures)
    check(not REJECTED.intersection(final_ids), "Rejected Student case is in final inventory", failures)
    check(sum(cid.startswith("API01-STU-") for cid in final_ids) == 5, "API-01 approved Student count is not 5", failures)
    check(sum(cid.startswith("API02-STU-") for cid in final_ids) == 5, "API-02 approved Student count is not 5", failures)
    check(sum(cid.startswith("API03-STU-") for cid in final_ids) == 5, "API-03 approved Student count is not 5", failures)

    missing_header = []
    for item in all_requests:
        headers = item["request"].get("header", [])
        student_headers = [h for h in headers if h.get("key", "").lower() == "x-student-id"]
        if len(student_headers) != 1 or student_headers[0].get("value") != "{{studentId}}":
            missing_header.append(item["name"])
    check(not missing_header, f"Missing/duplicate/bad X-Student-Id: {missing_header}", failures)

    for item in testcase_requests:
        cid = item["x-case-id"]
        prefix = cid.split("-")[0]
        method, path = EXPECTED_ENDPOINTS[prefix]
        request = item["request"]
        check(request["method"] == method, f"{cid}: wrong method", failures)
        check(request["url"]["raw"] == "{{baseUrl}}" + path, f"{cid}: wrong path", failures)
        check(item["name"].startswith(f"[{cid}] "), f"{cid}: unstable request name", failures)
        desc = request.get("description", "")
        for field in ("CASE_ID", "SOURCE", "REQUIREMENT_IDS", "PRIMARY_TECHNIQUE", "ORACLE_BASIS", "EXECUTION_MODE", "SETUP_REQUIREMENTS", "EXTERNAL_VERIFICATION", "ORDER_DEPENDENT", "DEPENDENCY"):
            check(f"{field}:" in desc, f"{cid}: missing description field {field}", failures)
        script = script_text(item)
        check("to.have.status" not in script, f"{cid}: invented testcase status assertion", failures)
        check("pm.sendRequest" not in script, f"{cid}: hidden network request in script", failures)

    final_dispositions = {item.get("final_disposition") for item in final_cases}
    check(final_dispositions == {"INCLUDED_EXECUTABLE"}, f"Unexpected final dispositions: {final_dispositions}", failures)
    check(all(item["test_case"].get("audit_status") != "INVALID" for item in final_cases), "Invalid case included", failures)
    check(all(item["test_case"].get("execution_status") != "DEFERRED_REQUIREMENT_GAP" for item in final_cases), "Deferred case included", failures)
    check(all(item["execution_mode"] in {"POSTMAN_DIRECT", "POSTMAN_WITH_PRECONDITION_SETUP", "POSTMAN_PLUS_EXTERNAL_VERIFICATION"} for item in final_cases), "Unknown execution mode", failures)
    check(all(item["external_verification"] != "NONE" for item in final_cases if item["execution_mode"] == "POSTMAN_PLUS_EXTERNAL_VERIFICATION"), "External mode missing plan", failures)

    env = load(ROOT / "postman" / "environments" / "HW06-Local.postman_environment.json")
    values = {item["key"]: item["value"] for item in env["values"]}
    check(values.get("baseUrl") == "http://localhost:3000", "Wrong local baseUrl", failures)
    check("studentId" in values, "studentId is not defined", failures)
    for secret in ("userPassword", "userToken", "otherUserPassword", "otherUserToken", "adminPassword", "adminToken", "expiredUserToken", "resetToken"):
        check(values.get(secret) == "", f"Secret-bearing environment field {secret} is not blank", failures)

    collection_text = COLLECTION.read_text(encoding="utf-8")
    check("multipart/form-data" not in collection_text, "Raw CSV/multipart assumption found", failures)
    check("pm.sendRequest" not in collection_text, "Hidden scripted SUT request found", failures)
    check("eyJhbGci" not in collection_text, "JWT-like value embedded", failures)

    modes = {
        mode: sum(item["execution_mode"] == mode for item in final_cases)
        for mode in ("POSTMAN_DIRECT", "POSTMAN_WITH_PRECONDITION_SETUP", "POSTMAN_PLUS_EXTERNAL_VERIFICATION")
    }
    per_api = {}
    for api in ("API-01", "API-02", "API-03"):
        rows = [item for item in final_cases if item["api_id"] == api]
        per_api[api] = {
            "total": len(rows),
            "AI_CORRECTED": sum(item["source"] == "AI_CORRECTED" for item in rows),
            "STUDENT_ADDED": sum(item["source"] == "STUDENT_ADDED" for item in rows),
            "POSTMAN_DIRECT": sum(item["execution_mode"] == "POSTMAN_DIRECT" for item in rows),
            "POSTMAN_WITH_PRECONDITION_SETUP": sum(item["execution_mode"] == "POSTMAN_WITH_PRECONDITION_SETUP" for item in rows),
            "POSTMAN_PLUS_EXTERNAL_VERIFICATION": sum(item["execution_mode"] == "POSTMAN_PLUS_EXTERNAL_VERIFICATION" for item in rows),
        }

    result = {
        "STATIC_VALIDATION": "PASS" if not failures else "FAIL",
        "FINAL_EXECUTABLE_TESTCASES": len(final_ids),
        "POSTMAN_TESTCASE_IDENTITIES": len(postman_ids),
        "POSTMAN_TOTAL_REQUESTS": len(all_requests),
        "SETUP_HELPER_REQUESTS": len(helpers),
        "POSTMAN_TESTCASE_COVERAGE": f"{len(set(final_ids).intersection(postman_ids))}/{len(final_ids)}",
        "TOTAL_SUT_REQUESTS": len(all_requests),
        "X_STUDENT_ID_COVERAGE": f"{len(all_requests) - len(missing_header)}/{len(all_requests)}",
        "MISSING_X_STUDENT_ID": missing_header,
        "INVALID_CASES_INCLUDED": 0 if "Invalid case included" not in failures else "NONZERO",
        "DEFERRED_CASES_INCLUDED_AS_BLOCKING": 0 if "Deferred case included" not in failures else "NONZERO",
        "REJECTED_STUDENT_CASES_INCLUDED": len(REJECTED.intersection(final_ids)),
        "EXECUTION_MODES": modes,
        "PER_API": per_api,
        "REAL_REQUESTS_EXECUTED": "NO",
        "NEWMAN_STARTED": "NO",
        "FAILURES": failures,
    }
    report_path = ROOT / "docs" / "postman" / "static-validation-report.json"
    report_path.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, ensure_ascii=False, indent=2))
    raise SystemExit(0 if not failures else 1)


if __name__ == "__main__":
    main()
