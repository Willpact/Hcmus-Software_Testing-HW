#!/usr/bin/env python3
"""Create a git-ignored HW06 runtime environment from trusted local sources.

The script intentionally prints only readiness/source metadata, never IDs,
passwords, JWTs, or disposable email values.
"""

from __future__ import annotations

import json
import re
from datetime import datetime
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
REPO = ROOT.parent
SUT = REPO / "eshop-sut"
RUNTIME_DIR = ROOT / "test-results" / "hw06" / "runtime"
RUNTIME_ENV = RUNTIME_DIR / "HW06-Local.runtime.postman_environment.json"
METADATA = RUNTIME_DIR / "runtime-configuration-metadata.json"

TRUSTED_STUDENT_PATTERNS = [
    (REPO / "HW1", "*_HW01_AI_Survey_98/AI_Disclosure_Form.md"),
    (REPO / "HW1", "*_HW01_AI_Survey_98/report.md"),
    (REPO / "HW4" / "Inclass", "*_MINILAB_POSTGRES/REPORT.md"),
]


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def extract_student_id():
    trusted_files = []
    for base, pattern in TRUSTED_STUDENT_PATTERNS:
        matches = list(base.glob(pattern))
        if len(matches) != 1:
            raise RuntimeError(f"Trusted source pattern did not resolve exactly once: {base.name}/{pattern}")
        trusted_files.append(matches[0])
    hits = []
    for path in trusted_files:
        text = path.read_text(encoding="utf-8-sig")
        values = re.findall(r"(?im)(?:student\s*id|mssv)[^\r\n0-9]*([0-9]{8})", text)
        hits.extend((path, value) for value in values)
    unique = sorted({value for _, value in hits})
    if len(unique) != 1 or len({path for path, _ in hits}) != len(trusted_files):
        raise RuntimeError("Trusted project sources do not establish exactly one explicit Student ID")
    sources = []
    for path, _ in hits:
        relative = str(path.relative_to(REPO)).replace("\\", "/")
        sources.append(re.sub(r"[0-9]{8}", "[student-id]", relative))
    return unique[0], sources


def extract_seed_users():
    path = SUT / "backend" / "database.js"
    text = path.read_text(encoding="utf-8-sig")
    pattern = re.compile(
        r"insertUser\.run\(\s*'([^']+)'\s*,\s*'([^']+)'\s*,\s*'([^']+)'\s*,\s*'([^']+)'\s*\)"
    )
    users = [dict(name=name, email=email, password=password, role=role) for name, email, password, role in pattern.findall(text)]
    admins = [user for user in users if user["role"] == "admin"]
    normals = [user for user in users if user["role"] == "user"]
    if len(admins) != 1 or len(normals) < 1:
        raise RuntimeError("Expected documented local seed admin and normal user fixtures")
    return admins[0], normals[0], path


def main():
    student_id, student_sources = extract_student_id()
    admin, normal, seed_path = extract_seed_users()
    template = read_json(ROOT / "postman" / "environments" / "HW06-Local.postman_environment.json")
    run_token = datetime.now().strftime("%Y%m%d%H%M%S")
    values = {entry["key"]: entry for entry in template["values"]}

    runtime_values = {
        "studentId": student_id,
        "baseUrl": "http://localhost:3000",
        "userEmail": normal["email"],
        "userPassword": normal["password"],
        "otherUserEmail": f"hw06-other-{run_token}@example.test",
        "otherUserPassword": "DisposableOther1!",
        "adminEmail": admin["email"],
        "adminPassword": admin["password"],
        "resetEmail": f"hw06-reset-{run_token}@example.test",
        "resetUserPassword": "DisposableReset1!",
        "newPassword": "DisposableChanged1!",
        "weakPassword": "weak",
        "wrongResetToken": "000000",
        "shippingAddress": f"HW06 disposable address {run_token}",
        "testRunId": run_token,
        "productId": "1",
        "categoryId": "1",
        "clientTotal": "200000",
        "otherCartTotal": "50000",
    }
    for key, value in runtime_values.items():
        if key in values:
            values[key]["value"] = value
        else:
            entry = {"key": key, "value": value, "type": "default", "enabled": True}
            template["values"].append(entry)
            values[key] = entry
    for token_key in ("userToken", "otherUserToken", "adminToken", "resetToken", "unusedResetToken", "usedResetToken", "expiredResetToken", "expiredUserToken"):
        if token_key in values:
            values[token_key]["value"] = ""

    template["id"] = "hw06-local-runtime"
    template["name"] = "HW06 Local Runtime (git-ignored)"
    template["_postman_exported_using"] = "HW06 runtime recovery; contains local disposable secrets; do not commit"
    RUNTIME_DIR.mkdir(parents=True, exist_ok=True)
    RUNTIME_ENV.write_text(json.dumps(template, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    metadata = {
        "student_id_configured": True,
        "student_id_value_logged": False,
        "student_id_sources": student_sources,
        "sources_agree": True,
        "seed_source": str(seed_path.relative_to(REPO)).replace("\\", "/"),
        "normal_user": "READY_FROM_SEED",
        "admin": "READY_FROM_SEED",
        "second_user": "READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT",
        "reset_user": "READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT",
        "runtime_environment": str(RUNTIME_ENV.relative_to(ROOT)).replace("\\", "/"),
        "runtime_environment_intended_for_commit": False,
        "secrets_logged": False,
    }
    METADATA.write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(metadata, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
