#!/usr/bin/env python3
"""Create redacted read-only external verification for smoke-002."""

from __future__ import annotations

import json
import sqlite3
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SMOKE = ROOT / "test-results" / "hw06" / "smoke-002"
DB = ROOT / "test-results" / "hw06" / "runtime" / "sut-db-003" / "database.sqlite"


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def response_json(execution):
    data = execution["response"]["stream"]["data"]
    return json.loads(bytes(data).decode("utf-8"))


def execution_map(report):
    return {entry["item"]["name"]: entry for entry in report["run"]["executions"]}


environment = {
    row["key"]: row.get("value")
    for row in load(SMOKE / "runtime-output.postman_environment.json")["values"]
}
main = execution_map(load(SMOKE / "newman.json"))
post = execution_map(load(SMOKE / "external-postcheck.newman.json"))

cart_before = response_json(main["[SETUP-API02-005] Capture primary cart"])
cart_after = response_json(post["[SMOKE-POST-001] Capture primary cart after checkout"])
checkout_response = response_json(main["[API02-AI-001] Checkout hợp lệ với cart có hàng"])
import_response = response_json(main["[API03-AI-001] Admin import một product hợp lệ"])
derived_cart_total = sum(float(item["price"]) * int(item["quantity"]) for item in cart_before)
imported_name = f"HW06-{environment['testRunId']}-API03-AI-001-A"

connection = sqlite3.connect(f"file:{DB.as_posix()}?mode=ro", uri=True)
try:
    password_rows = connection.execute(
        "SELECT password, reset_token FROM users WHERE email = ?",
        (environment["resetEmail"],),
    ).fetchall()
    order_row = connection.execute(
        "SELECT user_id, total_amount FROM orders WHERE id = ?",
        (checkout_response.get("orderId"),),
    ).fetchone()
    primary_user = connection.execute(
        "SELECT id FROM users WHERE email = ? ORDER BY id LIMIT 1",
        (environment["userEmail"],),
    ).fetchone()
    imported_count = connection.execute(
        "SELECT COUNT(*) FROM products WHERE name = ?",
        (imported_name,),
    ).fetchone()[0]
finally:
    connection.close()

plaintext_equal = any(row[0] == environment["newPassword"] for row in password_rows)
token_invalidated = any(row[0] == environment["newPassword"] and row[1] is None for row in password_rows)
order_total = order_row[1] if order_row else None
order_user_binding = bool(order_row and primary_user and order_row[0] == primary_user[0])
cart_cleared = len(cart_after) == 0

evidence = {
    "smoke_id": "smoke-002",
    "mode": "READ_ONLY_EXTERNAL_VERIFICATION",
    "database": "test-results/hw06/runtime/sut-db-003/database.sqlite",
    "secrets_logged": False,
    "student_id_logged": False,
    "api_01": {
        "case_id": "API01-AI-014",
        "reset_response_code": main["[API01-AI-014] Luồng issued đến reset thành công"]["response"]["code"],
        "otp_invalidated": token_invalidated,
        "valid_flow_status": "PASS" if token_invalidated else "FAIL",
        "additional_requirement_backed_observation": {
            "case_id": "API01-AI-035",
            "plaintext_equal": "YES" if plaintext_equal else "NO",
            "status": "FAIL" if plaintext_equal else "PASS",
            "preliminary_classification": "PRODUCT_DEFECT_CANDIDATE" if plaintext_equal else "PASS",
        },
    },
    "api_02": {
        "case_id": "API02-AI-001",
        "checkout_response_code": main["[API02-AI-001] Checkout hợp lệ với cart có hàng"]["response"]["code"],
        "cart_lines_before": len(cart_before),
        "cart_lines_after": len(cart_after),
        "cart_cleared": cart_cleared,
        "independently_derived_cart_total": derived_cart_total,
        "persisted_order_total": order_total,
        "persisted_total_matches_derived": order_total == derived_cart_total,
        "order_user_binding_matches_authenticated_user": order_user_binding,
        "status": "PASS" if cart_cleared and order_total == derived_cart_total and order_user_binding else "FAIL",
        "preliminary_classification": "PASS" if cart_cleared and order_total == derived_cart_total and order_user_binding else "PRODUCT_DEFECT_CANDIDATE",
    },
    "api_03": {
        "case_id": "API03-AI-001",
        "import_response_code": main["[API03-AI-001] Admin import một product hợp lệ"]["response"]["code"],
        "reported_inserted": import_response.get("inserted"),
        "matching_products_persisted": imported_count,
        "status": "PASS" if import_response.get("inserted") == 1 and imported_count >= 1 else "FAIL",
    },
}

(SMOKE / "external-verification.json").write_text(
    json.dumps(evidence, ensure_ascii=False, indent=2) + "\n",
    encoding="utf-8",
)
print(json.dumps(evidence, ensure_ascii=False, indent=2))
