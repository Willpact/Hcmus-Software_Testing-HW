"""Create deterministic, secret-safe derivatives of preserved Newman reports.

The four source reports are never changed. This utility replaces only values
that occur in sensitive request/header fields or that match a JWT pattern, and
records source/destination SHA-256 hashes without recording secret values.
"""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SOURCES = [
    ROOT / "test-results/hw06/run-001/newman.html",
    ROOT / "test-results/hw06/run-001/newman.json",
    ROOT / "test-results/hw06/run-001/external-postcheck.newman.json",
    ROOT / "test-results/hw06/run-002/newman.html",
    ROOT / "test-results/hw06/run-002/newman.json",
]
OUTPUT = ROOT / "docs/execution-results/redacted-newman"
JWT = re.compile(r"eyJ[a-zA-Z0-9_-]{20,}\.[a-zA-Z0-9_-]{10,}\.[a-zA-Z0-9_-]{10,}")
SENSITIVE_NAMES = {
    "authorization": "AUTHORIZATION",
    "xstudentid": "STUDENT_ID",
    "postmantoken": "POSTMAN_TOKEN",
    "password": "PASSWORD",
    "newpassword": "PASSWORD",
    "currentpassword": "PASSWORD",
    "passwordhash": "PASSWORD_HASH",
    "resettoken": "RESET_TOKEN",
    "token": "TOKEN",
    "jwt": "JWT",
}


def normalized(value: object) -> str:
    return re.sub(r"[^a-z0-9]", "", str(value).lower())


def collect_from_value(value: object, values: dict[str, str]) -> None:
    if isinstance(value, dict):
        for key, child in value.items():
            category = SENSITIVE_NAMES.get(normalized(key))
            if category and isinstance(child, str) and child:
                values[child] = category
            collect_from_value(child, values)
        header_name = value.get("key", value.get("name"))
        header_value = value.get("value")
        category = SENSITIVE_NAMES.get(normalized(header_name))
        if category and isinstance(header_value, str) and header_value:
            values[header_value] = category
    elif isinstance(value, list):
        for child in value:
            collect_from_value(child, values)
    elif isinstance(value, str):
        stripped = value.strip()
        if stripped[:1] in "[{":
            try:
                collect_from_value(json.loads(stripped), values)
            except json.JSONDecodeError:
                pass


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def student_id_literal() -> re.Pattern[str]:
    audit = (ROOT / "docs/ai-audit/AI_AUDIT_LOG.md").read_text(encoding="utf-8")
    match = re.search(r"\| Student ID \|\s*([^|\s]+)\s*\|", audit)
    if not match:
        raise RuntimeError("Student ID is unavailable for safe Newman redaction")
    return re.compile(rf"(?<!\d){re.escape(match.group(1))}(?!\d)")


def values_for_run(run: str) -> dict[str, str]:
    raw = (ROOT / f"test-results/hw06/{run}/newman.json").read_text(encoding="utf-8-sig")
    values: dict[str, str] = {}
    collect_from_value(json.loads(raw), values)
    for token in JWT.findall(raw):
        values[token] = "JWT"
    return values


def sanitize_source(source: Path, known_values: dict[str, str]) -> tuple[Path, dict[str, int]]:
    raw = source.read_text(encoding="utf-8-sig")
    values = dict(known_values)
    if source.suffix == ".json":
        collect_from_value(json.loads(raw), values)
    for token in JWT.findall(raw):
        values[token] = "JWT"

    counts: dict[str, int] = {}
    redacted = raw
    for value, category in sorted(values.items(), key=lambda item: len(item[0]), reverse=True):
        if value in redacted:
            redacted = redacted.replace(value, f"[REDACTED_{category}]")
            counts[category] = counts.get(category, 0) + 1
    redacted = JWT.sub("[REDACTED_JWT]", redacted)
    redacted = student_id_literal().sub("[REDACTED_STUDENT_ID]", redacted)

    destination = OUTPUT / source.parent.name / source.name
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(redacted, encoding="utf-8")
    return destination, counts


def main() -> None:
    OUTPUT.mkdir(parents=True, exist_ok=True)
    values_by_run = {run: values_for_run(run) for run in ("run-001", "run-002")}
    rows = []
    for source in SOURCES:
        destination, counts = sanitize_source(source, values_by_run[source.parent.name])
        rows.append((source, destination, counts, sha256(source), sha256(destination)))

    lines = [
        "# HW06 redacted Newman evidence manifest",
        "",
        "The preserved source reports under `test-results/hw06/` are genuine Newman execution outputs and remain unchanged. These deterministic derivatives are for repository/submission use only; no execution was rerun.",
        "",
        "## Sanitization boundary",
        "",
        "- Sanitization is deterministic: it replaces only JWT literals, sensitive request/header values and Student-ID literals with labelled redaction markers.",
        "- Testcase results, request/assertion counts, request names, timestamps, run identity, HTTP/business evidence and defect interpretation are not fabricated or changed.",
        "- Raw originals are excluded from public submission and final staging because they contain runtime credentials. They remain preserved locally as historical source evidence.",
        "- Source and derivative SHA-256 hashes below identify the exact inputs/outputs. They do not claim that the files have identical content, because redaction intentionally changes credential-bearing values.",
        "",
        "| Preserved source | Redacted derivative | Source SHA-256 | Redacted SHA-256 | Redaction categories |",
        "| --- | --- | --- | --- | --- |",
    ]
    for source, destination, counts, source_hash, output_hash in rows:
        lines.append(
            f"| `{source.relative_to(ROOT).as_posix()}` | `{destination.relative_to(ROOT).as_posix()}` | `{source_hash}` | `{output_hash}` | "
            + (", ".join(f"{key}: {value}" for key, value in sorted(counts.items())) or "JWT pattern only")
            + " |"
        )
    lines += [
        "",
        "The final package must include these redacted derivatives rather than the token-bearing raw `newman.html`/`newman.json` files. This does not alter the preserved historical execution artifacts.",
    ]
    (OUTPUT / "REDACTION-MANIFEST.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
