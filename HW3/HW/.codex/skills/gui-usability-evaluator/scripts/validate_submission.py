#!/usr/bin/env python3
import json
import sys
from pathlib import Path


REQUIRED_PATHS = [
    "README.md",
    "report/main-report.md",
    "report/main-report.pdf",
    "report/ai-audit-report.md",
    "report/ai-critique.md",
    "report/ai-appendix.pdf",
    "task1-gui-checklist/gui-checklist.md",
    "task1-gui-checklist/gui-checklist-results.json",
    "task1-gui-checklist/gui-checklist.xlsx",
    "task2-usability/01-usability-plan.md",
    "task2-usability/02-task-scenario.md",
    "task2-usability/03-moderator-guide.md",
    "task2-usability/04-sus-and-probes.md",
    "task2-usability/05-pilot-log.md",
    "task2-usability/data/sus-responses.csv",
    "task2-usability/data/session-metrics.csv",
    "task3-cross-platform/evidence-index.md",
    "git-commit-log.txt",
]


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: validate_submission.py <submission-directory>")
        return 2

    root = Path(sys.argv[1]).resolve()
    errors = []
    warnings = []

    if not root.is_dir():
        print(f"ERROR: submission directory not found: {root}")
        return 2

    for relative in REQUIRED_PATHS:
        path = root / relative
        if not path.is_file():
            errors.append(f"missing file: {relative}")
        elif path.stat().st_size == 0:
            errors.append(f"empty file: {relative}")

    results_path = root / "task1-gui-checklist/gui-checklist-results.json"
    if results_path.is_file():
        try:
            data = json.loads(results_path.read_text(encoding="utf-8"))
            rows = data.get("rows", [])
            if len(rows) <= 40:
                errors.append(f"GUI checklist has {len(rows)} rows; more than 40 required")
            aspects = {row.get("aspect") for row in rows}
            required_aspects = {"IA-01", "IA-02", "IA-03", "IA-04"}
            if not required_aspects.issubset(aspects):
                errors.append(f"GUI checklist missing aspects: {sorted(required_aspects - aspects)}")
            for row in rows:
                if row.get("status") not in {"Passed", "Failed"}:
                    errors.append(f"{row.get('id')}: invalid or missing status")
                if row.get("status") == "Failed":
                    if not row.get("notes"):
                        errors.append(f"{row.get('id')}: failed row has no notes")
                    if not row.get("evidence"):
                        errors.append(f"{row.get('id')}: failed row has no evidence link")
        except (OSError, json.JSONDecodeError) as error:
            errors.append(f"cannot parse GUI results: {error}")

    sus_path = root / "task2-usability/data/sus-responses.csv"
    if sus_path.is_file() and ",,,,,,,,,," in sus_path.read_text(encoding="utf-8"):
        warnings.append("SUS responses still contain blank participant rows")

    platform_index = root / "task3-cross-platform/evidence-index.md"
    if platform_index.is_file() and "Not executed" in platform_index.read_text(encoding="utf-8"):
        warnings.append("cross-platform evidence is not complete")

    private_register = root / "task2-usability/private/participant-register.md"
    if not private_register.is_file():
        warnings.append("private participant register is not present")

    print(f"Submission: {root}")
    print(f"Errors: {len(errors)}")
    for error in errors:
        print(f"- ERROR: {error}")
    print(f"Warnings: {len(warnings)}")
    for warning in warnings:
        print(f"- WARNING: {warning}")
    print(
        "Structural validation cannot verify that human participants, recordings, "
        "screenshots, student review, or issue narratives are genuine."
    )
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
