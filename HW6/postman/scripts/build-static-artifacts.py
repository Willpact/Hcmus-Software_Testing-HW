#!/usr/bin/env python3
"""Build the approved HW06 final inventory and static Postman review draft.

This script only reads local JSON and writes local JSON/Markdown. It never starts
the SUT, sends a request, runs Postman/Newman, or produces runtime evidence.
"""

from __future__ import annotations

import copy
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
API_CONFIG = {
    "API-01": {
        "slug": "api-01-reset-password",
        "label": "API-01 Reset Password",
        "method": "POST",
        "path": "/api/reset-password",
    },
    "API-02": {
        "slug": "api-02-checkout",
        "label": "API-02 Checkout",
        "method": "POST",
        "path": "/api/checkout",
    },
    "API-03": {
        "slug": "api-03-import-products",
        "label": "API-03 Import Products",
        "method": "POST",
        "path": "/api/admin/import-products",
    },
}

EXTERNAL_API01 = {"API01-AI-027", "API01-AI-035"}
EXTERNAL_API03 = {"API03-AI-029", "API03-STU-003"}
REJECTED_STUDENT_IDS = {"API02-STU-004", "API03-STU-005"}


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def write_json(path: Path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def write_text(path: Path, value: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(value.rstrip() + "\n", encoding="utf-8")


def load_cases(api_id: str):
    cfg = API_CONFIG[api_id]
    corrected = read_json(ROOT / "test-cases" / "corrected" / f"{cfg['slug']}.json")
    student = read_json(ROOT / "test-cases" / "student-added" / f"{cfg['slug']}.json")
    ai_cases = [copy.deepcopy(item["test_case"]) for item in corrected["executable_cases"]]
    approved = [
        copy.deepcopy(item["test_case"])
        for item in student["student_cases"]
        if item.get("human_review_status") == "APPROVED"
        and item.get("count_toward_student_extension") == "YES"
    ]
    rejected = [
        item["test_case"]["id"]
        for item in student["student_cases"]
        if item.get("count_toward_student_extension") != "YES"
    ]
    if len(approved) != 5:
        raise ValueError(f"{api_id}: expected 5 approved Student cases, found {len(approved)}")
    return corrected, ai_cases, approved, rejected


def execution_mode(api_id: str, case: dict) -> str:
    cid = case["id"]
    reqs = set(case.get("requirement_ids", []))
    if api_id == "API-01" and cid in EXTERNAL_API01:
        return "POSTMAN_PLUS_EXTERNAL_VERIFICATION"
    if api_id == "API-02" and reqs.intersection({"API02-REQ-005", "API02-REQ-006", "API02-REQ-011"}):
        return "POSTMAN_PLUS_EXTERNAL_VERIFICATION"
    if api_id == "API-03" and cid in EXTERNAL_API03:
        return "POSTMAN_PLUS_EXTERNAL_VERIFICATION"
    return "POSTMAN_WITH_PRECONDITION_SETUP"


def setup_requirements(api_id: str, case: dict) -> list[str]:
    requirements = list(case.get("preconditions", []))
    if api_id == "API-01":
        requirements.append("Use POST /api/forgot-password when an issued OTP is required")
    elif api_id == "API-02":
        requirements.append("Use documented login/cart helpers with isolated user carts")
    else:
        requirements.append("Use documented login and GET /api/products baseline helper")
    return list(dict.fromkeys(requirements))


def external_requirement(api_id: str, case: dict, mode: str) -> str:
    if mode != "POSTMAN_PLUS_EXTERNAL_VERIFICATION":
        return "NONE"
    cid = case["id"]
    reqs = set(case.get("requirement_ids", []))
    if cid == "API01-AI-035":
        return "Read-only isolated datastore inspection proving the stored password is not plaintext; redact all secret values."
    if api_id == "API-01":
        return "Read-only before/after datastore integrity snapshot proving the injection-like input caused no unauthorized user-data change."
    if api_id == "API-02":
        parts = []
        if reqs.intersection({"API02-REQ-005", "API02-REQ-006"}):
            parts.append("independently calculate cart total and inspect the persisted order total/user binding")
        if "API02-REQ-011" in reqs:
            parts.append("compare unrelated datastore objects before/after the injection-like address payload")
        return "Read-only isolated verification: " + "; ".join(parts) + "."
    return "Read-only product/database snapshot proving batch atomicity and unrelated-data integrity for injection-like input."


def order_dependency(case: dict) -> tuple[str, str]:
    techniques = set(case.get("technique", []))
    text = " ".join(case.get("preconditions", [])).lower()
    is_sequence = "STATE_TRANSITION" in techniques or any(
        marker in text for marker in ("đã thành công", "trước import", "before both", "completed")
    )
    if not is_sequence:
        return "NO", "NONE; reusable setup creates an isolated fixture before the testcase action."
    return "YES", "Execute only the explicit state-transition sequence described by the testcase preconditions/objective using isolated fixtures."


def api01_body(cid: str):
    body = {"email": "{{resetEmail}}", "resetToken": "{{resetToken}}", "newPassword": "{{newPassword}}"}
    if cid == "API01-AI-002": body["email"] = "{{otherUserEmail}}"
    elif cid == "API01-AI-003": body["resetToken"] = "{{unusedResetToken}}"
    elif cid == "API01-AI-004": body["email"] = "unregistered+{{testRunId}}@example.invalid"
    elif cid == "API01-AI-005": body.pop("email")
    elif cid == "API01-AI-006": body.pop("resetToken")
    elif cid == "API01-AI-007": body.pop("newPassword")
    elif cid == "API01-AI-008": body["resetToken"] = "12ab"
    elif cid == "API01-AI-009": body["newPassword"] = "Ab1!xyz"
    elif cid == "API01-AI-010": body["newPassword"] = "Abcde1!x"
    elif cid == "API01-AI-011": body["resetToken"] = "12345"
    elif cid == "API01-AI-015": body["resetToken"] = "{{usedResetToken}}"
    elif cid == "API01-AI-016": body["resetToken"] = "{{expiredResetToken}}"
    elif cid == "API01-AI-018": body["newPassword"] = "{{weakPassword}}"
    elif cid in {"API01-AI-019", "API01-STU-003"}: body["resetToken"] = "{{wrongResetToken}}"
    elif cid == "API01-AI-021": body["newPassword"] = "abcdef1!"
    elif cid == "API01-AI-022": body["newPassword"] = "ABCDEF1!"
    elif cid == "API01-AI-023": body["newPassword"] = "Abcdefg!"
    elif cid == "API01-AI-024": body["newPassword"] = "Abcdef12"
    elif cid == "API01-AI-027": body["email"] = "' OR 1=1 --"
    elif cid == "API01-AI-028": body["resetToken"] = "' OR '1'='1"
    elif cid == "API01-STU-001": body["email"] = "{{otherUserEmail}}"
    elif cid == "API01-STU-002": body["newPassword"] = "{{weakPassword}}"
    return body


def api02_body(cid: str):
    body = {"total_amount": "{{clientTotal}}", "shipping_address": "{{shippingAddress}}"}
    if cid == "API02-AI-002": body["total_amount"] = 1
    elif cid == "API02-AI-003": body["total_amount"] = 999999999
    elif cid == "API02-AI-004": body["total_amount"] = 0
    elif cid == "API02-AI-005": body["total_amount"] = -1
    elif cid == "API02-AI-006": body["total_amount"] = "200000"
    elif cid == "API02-AI-007": body.pop("total_amount")
    elif cid == "API02-AI-025": body["total_amount"] = "0); DROP TABLE orders; --"
    elif cid in {"API02-AI-026", "API02-STU-003"}: body["shipping_address"] = "'; DROP TABLE users; --"
    elif cid in {"API02-AI-027", "API02-STU-002"}: body["user_id"] = "{{otherUserId}}"
    elif cid in {"API02-STU-005", "API02-STU-006"}: body["total_amount"] = "{{otherCartTotal}}"
    return body


def valid_product(cid: str, suffix: str = "A"):
    return {
        "name": f"HW06-{{{{testRunId}}}}-{cid}-{suffix}",
        "price": 10000,
        "description": f"Disposable fixture for {cid}",
        "imageUrl": "",
        "category_id": "{{categoryId}}",
    }


def api03_body(cid: str):
    if cid == "API03-AI-003": return {}
    if cid == "API03-AI-004": return {"products": None}
    if cid == "API03-AI-005": return {"products": valid_product(cid)}
    p = valid_product(cid)
    if cid == "API03-AI-007": p.pop("name")
    elif cid == "API03-AI-008": p["name"] = ""
    elif cid == "API03-AI-009": p["price"] = 0
    elif cid == "API03-AI-010": p["price"] = -1
    elif cid == "API03-AI-011": p["price"] = 0.01
    elif cid == "API03-AI-028": p["role"] = "admin"
    elif cid in {"API03-AI-029", "API03-STU-003"}: p["name"] = "'); DROP TABLE products; --"
    if cid in {"API03-AI-002", "API03-AI-017", "API03-AI-018", "API03-AI-019", "API03-AI-020", "API03-AI-022", "API03-AI-038", "API03-STU-001", "API03-STU-002", "API03-STU-003", "API03-STU-004", "API03-STU-006"}:
        q = valid_product(cid, "B")
        if cid in {"API03-AI-017", "API03-STU-001", "API03-STU-002"}: p["name"] = ""
        elif cid in {"API03-AI-018", "API03-AI-022", "API03-AI-038", "API03-STU-003", "API03-STU-004", "API03-STU-006"}: q["price"] = -1
        elif cid in {"API03-AI-019", "API03-AI-020"}: q["name"] = ""
        return {"products": [p, q]}
    return {"products": [p]}


def case_body(api_id: str, cid: str):
    if api_id == "API-01": return api01_body(cid)
    if api_id == "API-02": return api02_body(cid)
    return api03_body(cid)


def postman_raw_json(body) -> str:
    """Render selected numeric variables without JSON quotes."""
    raw = json.dumps(body, ensure_ascii=False, indent=2)
    for variable in ("clientTotal", "otherCartTotal", "categoryId", "productId"):
        raw = raw.replace('"{{' + variable + '}}"', "{{" + variable + "}}")
    return raw


def auth_for(api_id: str, cid: str):
    if api_id == "API-01": return {"type": "noauth"}
    if api_id == "API-02":
        if cid == "API02-AI-021": return {"type": "noauth"}
        if cid == "API02-AI-022": return {"type": "header", "value": "Basic {{userToken}}"}
        if cid == "API02-AI-023": return {"type": "header", "value": "Bearer malformed.jwt.token"}
        if cid == "API02-AI-024": return {"type": "header", "value": "Bearer {{expiredUserToken}}"}
        if cid == "API02-STU-001": return {"type": "header", "value": "Bearer malformed.jwt.token"}
        return {"type": "bearer", "variable": "userToken"}
    if cid == "API03-AI-023": return {"type": "noauth"}
    if cid == "API03-AI-024": return {"type": "header", "value": "Bearer malformed.jwt.token"}
    if cid == "API03-AI-025": return {"type": "header", "value": "Bearer {{expiredUserToken}}"}
    if cid in {"API03-AI-026", "API03-AI-028", "API03-STU-001", "API03-STU-002"}: return {"type": "bearer", "variable": "userToken"}
    return {"type": "bearer", "variable": "adminToken"}


def request_headers(auth: dict):
    headers = [
        {"key": "Content-Type", "value": "application/json", "type": "text"},
        {"key": "X-Student-Id", "value": "{{studentId}}", "type": "text"},
    ]
    if auth["type"] == "header":
        headers.append({"key": "Authorization", "value": auth["value"], "type": "text"})
    return headers


def postman_auth(auth: dict):
    if auth["type"] == "bearer":
        return {"type": "bearer", "bearer": [{"key": "token", "value": "{{" + auth["variable"] + "}}", "type": "string"}]}
    return {"type": "noauth"}


def description(record: dict) -> str:
    c = record["test_case"]
    return "\n".join([
        f"CASE_ID: {record['case_id']}",
        f"SOURCE: {record['source']}",
        f"REQUIREMENT_IDS: {', '.join(c.get('requirement_ids', []))}",
        f"PRIMARY_TECHNIQUE: {c.get('primary_technique', '')}",
        f"ORACLE_BASIS: {c.get('oracle_basis', '')}",
        f"EXECUTION_MODE: {record['execution_mode']}",
        "SETUP_REQUIREMENTS: " + " | ".join(record["setup_requirements"]),
        f"EXTERNAL_VERIFICATION: {record['external_verification']}",
        f"ORDER_DEPENDENT: {record['order_dependent']}",
        f"DEPENDENCY: {record['dependency']}",
        f"BUSINESS_ORACLE: {c.get('expected_business_result', '')}",
        f"STATE_ORACLE: {c.get('expected_state', '')}",
        "EVIDENCE_BOUNDARY: No unspecified response status or schema is asserted. Execute setup/postcondition or external verification before deciding PASS/FAIL.",
    ])


def test_script(cid: str):
    return [
        f"const caseId = {json.dumps(cid)};",
        "const resolvedStudentId = pm.variables.replaceIn('{{studentId}}');",
        "pm.test(`[${caseId}] studentId is configured`, function () {",
        "  pm.expect(resolvedStudentId).to.not.equal('{{studentId}}');",
        "  pm.expect(resolvedStudentId).to.not.be.empty;",
        "});",
        "pm.test(`[${caseId}] response captured for approved oracle workflow`, function () {",
        "  pm.expect(pm.response).to.exist;",
        "  pm.expect(pm.response.code).to.be.a('number');",
        "});",
        "pm.environment.set(`observed_${caseId}_status`, String(pm.response.code));",
        "pm.environment.set(`observed_${caseId}_body`, pm.response.text());",
        "// Business/state PASS requires the setup, postcondition, and external checks declared in the request description.",
        "// No undocumented status code or response-field assertion is introduced here.",
    ]


def testcase_item(api_id: str, record: dict):
    c = record["test_case"]
    auth = auth_for(api_id, record["case_id"])
    body = case_body(api_id, record["case_id"])
    return {
        "name": record["postman_request"],
        "description": description(record),
        "request": {
            "method": API_CONFIG[api_id]["method"],
            "header": request_headers(auth),
            "body": {"mode": "raw", "raw": postman_raw_json(body), "options": {"raw": {"language": "json"}}},
            "url": {"raw": "{{baseUrl}}" + API_CONFIG[api_id]["path"], "host": ["{{baseUrl}}"], "path": API_CONFIG[api_id]["path"].lstrip("/").split("/")},
            "auth": postman_auth(auth),
            "description": description(record),
        },
        "event": [{"listen": "test", "script": {"type": "text/javascript", "exec": test_script(record["case_id"])}}],
        "protocolProfileBehavior": {"disableBodyPruning": True},
        "x-case-id": record["case_id"],
        "x-case-source": record["source"],
        "x-execution-mode": record["execution_mode"],
    }


def helper_item(name: str, method: str, path: str, body, auth: dict, test_lines=None):
    request = {
        "method": method,
        "header": request_headers(auth),
        "url": {"raw": "{{baseUrl}}" + path, "host": ["{{baseUrl}}"], "path": path.lstrip("/").split("/")},
        "auth": postman_auth(auth),
        "description": "Reusable setup/precheck helper. It is not a final testcase identity and must use disposable fixtures.",
    }
    if body is not None:
        request["body"] = {"mode": "raw", "raw": postman_raw_json(body), "options": {"raw": {"language": "json"}}}
    item = {"name": name, "request": request, "x-helper": True}
    if test_lines:
        item["event"] = [{"listen": "test", "script": {"type": "text/javascript", "exec": test_lines}}]
    return item


def setup_items(api_id: str):
    noauth = {"type": "noauth"}
    user = {"type": "bearer", "variable": "userToken"}
    other = {"type": "bearer", "variable": "otherUserToken"}
    if api_id == "API-01":
        return [helper_item(
            "[SETUP-API01-001] Issue reset OTP", "POST", "/api/forgot-password", {"email": "{{resetEmail}}"}, noauth,
            [
                "pm.test('Documented forgot-password success is 200 when the fixture is valid', () => pm.response.to.have.status(200));",
                "const data = pm.response.json();",
                "if (data.resetToken) pm.environment.set('resetToken', String(data.resetToken));",
            ],
        )]
    login_script = lambda variable: [
        "pm.test('Documented login success is 200 when credentials are valid', () => pm.response.to.have.status(200));",
        "const data = pm.response.json();",
        f"if (data.token) pm.environment.set('{variable}', data.token);",
    ]
    if api_id == "API-02":
        return [
            helper_item("[SETUP-API02-001] Login primary user", "POST", "/api/login", {"email": "{{userEmail}}", "password": "{{userPassword}}"}, noauth, login_script("userToken")),
            helper_item("[SETUP-API02-002] Login second user", "POST", "/api/login", {"email": "{{otherUserEmail}}", "password": "{{otherUserPassword}}"}, noauth, login_script("otherUserToken")),
            helper_item("[SETUP-API02-003] Prepare primary cart", "POST", "/api/cart", {"id": "{{productId}}", "name": "HW06 {{testRunId}}", "price": 100000, "quantity": 2}, user),
            helper_item("[SETUP-API02-004] Prepare second-user cart", "POST", "/api/cart", {"id": "{{productId}}", "name": "HW06 other {{testRunId}}", "price": 50000, "quantity": 1}, other),
            helper_item("[SETUP-API02-005] Capture primary cart", "GET", "/api/cart", None, user, ["pm.environment.set('primaryCartSnapshot', pm.response.text());"]),
            helper_item("[SETUP-API02-006] Capture second-user cart", "GET", "/api/cart", None, other, ["pm.environment.set('otherCartSnapshot', pm.response.text());"]),
        ]
    return [
        helper_item("[SETUP-API03-001] Login admin", "POST", "/api/login", {"email": "{{adminEmail}}", "password": "{{adminPassword}}"}, noauth, login_script("adminToken")),
        helper_item("[SETUP-API03-002] Login non-admin user", "POST", "/api/login", {"email": "{{userEmail}}", "password": "{{userPassword}}"}, noauth, login_script("userToken")),
        helper_item("[SETUP-API03-003] Capture product baseline", "GET", "/api/products", None, noauth, ["pm.environment.set('productBaseline', pm.response.text());"]),
    ]


def environment(name: str, example: bool):
    values = {
        "baseUrl": "http://localhost:3000",
        "studentId": "",
        "userEmail": "",
        "userPassword": "",
        "userToken": "",
        "otherUserEmail": "",
        "otherUserPassword": "",
        "otherUserToken": "",
        "otherUserId": "",
        "adminEmail": "",
        "adminPassword": "",
        "adminToken": "",
        "expiredUserToken": "",
        "resetEmail": "",
        "resetToken": "",
        "unusedResetToken": "",
        "usedResetToken": "",
        "expiredResetToken": "",
        "wrongResetToken": "000000",
        "newPassword": "Disposable1!",
        "weakPassword": "weak",
        "shippingAddress": "HW06 disposable address",
        "productId": "1",
        "categoryId": "1",
        "clientTotal": "200000",
        "otherCartTotal": "50000",
        "testRunId": "",
    }
    return {
        "id": "hw06-local-example" if example else "hw06-local",
        "name": name,
        "values": [{"key": k, "value": v, "type": "default", "enabled": True} for k, v in values.items()],
        "_postman_variable_scope": "environment",
        "_postman_exported_using": "HW06 static builder; no runtime execution",
    }


def build():
    all_records = []
    per_api = {}
    rejected_seen = []
    for api_id, cfg in API_CONFIG.items():
        corrected, ai_cases, student_cases, rejected = load_cases(api_id)
        rejected_seen.extend(rejected)
        records = []
        for source, cases in (("AI_CORRECTED", ai_cases), ("STUDENT_ADDED", student_cases)):
            for case in cases:
                mode = execution_mode(api_id, case)
                order, dependency = order_dependency(case)
                record = {
                    "case_id": case["id"],
                    "api_id": api_id,
                    "source": source,
                    "human_review_status": "APPROVED",
                    "final_disposition": "INCLUDED_EXECUTABLE",
                    "execution_mode": mode,
                    "setup_requirements": setup_requirements(api_id, case),
                    "external_verification": external_requirement(api_id, case, mode),
                    "order_dependent": order,
                    "dependency": dependency,
                    "postman_request": f"[{case['id']}] {case['title']}",
                    "test_case": case,
                }
                records.append(record)
                all_records.append(record)
        mode_counts = {m: sum(r["execution_mode"] == m for r in records) for m in (
            "POSTMAN_DIRECT", "POSTMAN_WITH_PRECONDITION_SETUP", "POSTMAN_PLUS_EXTERNAL_VERIFICATION")}
        summary = {
            "raw_ai_generated": corrected["summary"]["raw_ai_generated"],
            "ai_corrected_executable": len(ai_cases),
            "student_added_approved": len(student_cases),
            "total_executable": len(records),
            "deferred": corrected["summary"]["incomplete_deferred"],
            "invalid_removed": corrected["summary"]["invalid_removed"],
            "execution_modes": mode_counts,
        }
        per_api[api_id] = {"summary": summary, "records": records}
        write_json(ROOT / "test-cases" / "final" / f"{cfg['slug']}.json", {
            "metadata": {"api_id": api_id, "status": "POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED", "execution_status": "NOT_EXECUTED"},
            "summary": summary,
            "cases": records,
        })
        data_rows = []
        for record in records:
            c = record["test_case"]
            data_rows.append({
                "case_id": record["case_id"],
                "source": record["source"],
                "method": cfg["method"],
                "path": cfg["path"],
                "auth": auth_for(api_id, record["case_id"]),
                "body": case_body(api_id, record["case_id"]),
                "body_variation": c.get("request", {}).get("body_variation") or c.get("request", {}).get("sequence_or_body_variation"),
                "requirements": c.get("requirement_ids", []),
                "business_oracle": c.get("expected_business_result"),
                "state_oracle": c.get("expected_state"),
                "execution_mode": record["execution_mode"],
                "setup_requirements": record["setup_requirements"],
                "external_verification": record["external_verification"],
                "order_dependent": record["order_dependent"],
                "dependency": record["dependency"],
            })
        write_json(ROOT / "postman" / "data" / f"{cfg['slug']}.json", data_rows)

    ids = [r["case_id"] for r in all_records]
    if len(ids) != len(set(ids)):
        raise ValueError("Duplicate final case IDs")
    if REJECTED_STUDENT_IDS.intersection(ids):
        raise ValueError("Rejected Student case included")
    if set(rejected_seen) != REJECTED_STUDENT_IDS:
        raise ValueError(f"Unexpected rejected history set: {rejected_seen}")

    cross_summary = {
        "status": "POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED",
        "execution_status": "NOT_EXECUTED",
        "sources": ["test-cases/corrected/", "test-cases/student-added/"],
        "excluded_dispositions": ["INVALID", "DEFERRED_REQUIREMENT_GAP", "REJECTED_AS_STUDENT_EXTENSION"],
        "per_api": {api_id: data["summary"] for api_id, data in per_api.items()},
        "totals": {
            "raw_ai_generated": sum(data["summary"]["raw_ai_generated"] for data in per_api.values()),
            "ai_corrected_executable": sum(data["summary"]["ai_corrected_executable"] for data in per_api.values()),
            "student_added_approved": sum(data["summary"]["student_added_approved"] for data in per_api.values()),
            "total_executable": len(all_records),
            "deferred": sum(data["summary"]["deferred"] for data in per_api.values()),
            "invalid_removed": sum(data["summary"]["invalid_removed"] for data in per_api.values()),
            "execution_modes": {
                mode: sum(data["summary"]["execution_modes"][mode] for data in per_api.values())
                for mode in ("POSTMAN_DIRECT", "POSTMAN_WITH_PRECONDITION_SETUP", "POSTMAN_PLUS_EXTERNAL_VERIFICATION")
            },
        },
        "rejected_student_history_excluded": sorted(REJECTED_STUDENT_IDS),
    }
    write_json(ROOT / "test-cases" / "final" / "cross-api-final-summary.json", cross_summary)

    folders = []
    for api_id, cfg in API_CONFIG.items():
        folders.append({
            "name": cfg["label"],
            "item": [
                {"name": "Setup", "item": setup_items(api_id)},
                {"name": "Test Cases", "item": [testcase_item(api_id, r) for r in per_api[api_id]["records"]]},
            ],
        })
    collection = {
        "info": {
            "_postman_id": "hw06-api-testing-static-review-draft",
            "name": "HW06 API Testing",
            "description": "Static review draft built only from Human-approved corrected and Student-added cases. No runtime result is included.",
            "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
        },
        "event": [{
            "listen": "prerequest",
            "script": {"type": "text/javascript", "exec": [
                "if (!pm.environment.get('testRunId')) {",
                "  pm.environment.set('testRunId', `${Date.now()}-${Math.floor(Math.random() * 100000)}`);",
                "}",
            ]},
        }],
        "item": folders,
    }
    write_json(ROOT / "postman" / "collections" / "HW06-API-Testing.postman_collection.json", collection)
    write_json(ROOT / "postman" / "environments" / "HW06-Local.postman_environment.json", environment("HW06 Local", False))
    write_json(ROOT / "postman" / "environments" / "HW06-Local.example.postman_environment.json", environment("HW06 Local Example", True))

    suite_lines = [
        "# Final Executable API Test Suite",
        "",
        "Status: `POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED`  ",
        "Execution: `NOT_EXECUTED`",
        "",
        "Only Human-approved corrected AI cases and approved Student Extension cases are included. Invalid, deferred requirement-gap, and rejected Student history cases are excluded.",
        "",
        "| API | Raw AI | AI corrected executable | Student approved | Total executable | Deferred | Invalid removed | Direct | With setup | Plus external |",
        "| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |",
    ]
    for api_id, data in per_api.items():
        s, m = data["summary"], data["summary"]["execution_modes"]
        suite_lines.append(f"| {api_id} | {s['raw_ai_generated']} | {s['ai_corrected_executable']} | {s['student_added_approved']} | {s['total_executable']} | {s['deferred']} | {s['invalid_removed']} | {m['POSTMAN_DIRECT']} | {m['POSTMAN_WITH_PRECONDITION_SETUP']} | {m['POSTMAN_PLUS_EXTERNAL_VERIFICATION']} |")
    t, m = cross_summary["totals"], cross_summary["totals"]["execution_modes"]
    suite_lines += [
        f"| **Total** | **{t['raw_ai_generated']}** | **{t['ai_corrected_executable']}** | **{t['student_added_approved']}** | **{t['total_executable']}** | **{t['deferred']}** | **{t['invalid_removed']}** | **{m['POSTMAN_DIRECT']}** | **{m['POSTMAN_WITH_PRECONDITION_SETUP']}** | **{m['POSTMAN_PLUS_EXTERNAL_VERIFICATION']}** |",
        "",
        "## Inclusion boundary",
        "",
        "- Student Extension remains API-01 `5`, API-02 `5`, API-03 `5`, total `15`.",
        "- `API02-STU-004` and `API03-STU-005` remain rejected history only.",
        "- Surviving IDs are not renumbered, and no filler cases were generated.",
        "- Execution modes describe the required evidence path; they are not runtime results.",
    ]
    write_text(ROOT / "docs" / "test-suite" / "final-executable-suite.md", "\n".join(suite_lines))

    manifest = [
        "# Postman Execution Manifest",
        "",
        "Status: `POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED` — `NOT_EXECUTED`",
        "",
        "| CASE_ID | SOURCE | API | TECHNIQUE | POSTMAN_REQUEST | EXECUTION_MODE | SETUP_REQUIRED | EXTERNAL_VERIFICATION | REQUIREMENT_IDS | ORDER_DEPENDENT | DEPENDENCY |",
        "| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |",
    ]
    for r in all_records:
        c = r["test_case"]
        esc = lambda v: str(v).replace("|", "\\|").replace("\n", " ")
        manifest.append("| " + " | ".join(map(esc, [
            r["case_id"], r["source"], r["api_id"], c.get("primary_technique", ""), r["postman_request"],
            r["execution_mode"], "YES", r["external_verification"], ", ".join(c.get("requirement_ids", [])), r["order_dependent"], r["dependency"],
        ])) + " |")
    write_text(ROOT / "docs" / "postman" / "execution-manifest.md", "\n".join(manifest))

    external = [
        "# External Verification Plan",
        "",
        "Status: `PLANNED_NOT_EXECUTED`",
        "",
        "External verification is required only where the authoritative state/integrity oracle cannot be proven from the selected endpoint response without inventing a schema. Use an isolated disposable test datastore and redact secrets.",
        "",
        "| CASE_ID | API | POSTMAN_VERIFICATION | EXTERNAL_VERIFICATION | VERIFICATION_METHOD | EXPECTED_INVARIANT | EVIDENCE_REQUIRED |",
        "| --- | --- | --- | --- | --- | --- | --- |",
    ]
    for r in all_records:
        if r["execution_mode"] != "POSTMAN_PLUS_EXTERNAL_VERIFICATION": continue
        c = r["test_case"]
        esc = lambda v: str(v).replace("|", "\\|").replace("\n", " ")
        row = [
            r["case_id"], r["api_id"], "Capture action response and run the documented reusable setup/precheck; do not infer persistence from the response alone.",
            r["external_verification"], "Read-only before/after inspection in the isolated test environment.",
            c.get("expected_state", "") or c.get("expected_business_result", ""),
            "Redacted before/after snapshot, fixture identifiers containing testRunId, and tester decision; no secrets or fabricated runtime output.",
        ]
        external.append("| " + " | ".join(map(esc, row)) + " |")
    write_text(ROOT / "docs" / "postman" / "external-verification-plan.md", "\n".join(external))

    readme = """# HW06 Postman Static Review Draft

Status: `POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED`  
Runtime evidence: `NONE`

This collection contains one stable testcase identity for each of the 93 final executable cases, plus 10 reusable setup/precheck helpers. It was generated from approved local artifacts only. It has not sent network traffic and must not be described as passed or failed.

## Files

- `collections/HW06-API-Testing.postman_collection.json`: one collection with three API folders, each split into `Setup` and `Test Cases`.
- `environments/HW06-Local.postman_environment.json`: local, secret-free environment to fill before execution.
- `environments/HW06-Local.example.postman_environment.json`: shareable example with no real credentials or tokens.
- `data/*.json`: one row per final testcase, including body variation, oracle, mode, setup, and dependency metadata.

## Review and later execution

1. Review the final inventory, request bodies, auth variants, setup dependencies, and external plan.
2. Fill disposable fixture credentials/tokens locally; do not commit secrets.
3. Keep `X-Student-Id: {{studentId}}` on every SUT request.
4. Execute only after explicit Human approval. The current checkpoint forbids SUT startup, Postman Runner, Newman, screenshots, and runtime verdicts.

Generic testcase scripts only verify configuration and capture the response. They intentionally do not invent status codes or response schemas. A testcase PASS/FAIL decision requires the business/state oracle and any declared postcondition/external verification.
"""
    write_text(ROOT / "postman" / "README.md", readme)
    print(json.dumps(cross_summary["totals"], ensure_ascii=False, indent=2))


if __name__ == "__main__":
    build()
