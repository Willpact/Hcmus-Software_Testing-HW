# HW06 redacted Newman evidence manifest

The preserved source reports under `test-results/hw06/` are genuine Newman execution outputs and remain unchanged. These deterministic derivatives are for repository/submission use only; no execution was rerun.

## Sanitization boundary

- Sanitization is deterministic: it replaces only JWT literals, sensitive request/header values and Student-ID literals with labelled redaction markers.
- Testcase results, request/assertion counts, request names, timestamps, run identity, HTTP/business evidence and defect interpretation are not fabricated or changed.
- Raw originals are excluded from public submission and final staging because they contain runtime credentials. They remain preserved locally as historical source evidence.
- Source and derivative SHA-256 hashes below identify the exact inputs/outputs. They do not claim that the files have identical content, because redaction intentionally changes credential-bearing values.

| Preserved source | Redacted derivative | Source SHA-256 | Redacted SHA-256 | Redaction categories |
| --- | --- | --- | --- | --- |
| `test-results/hw06/run-001/newman.html` | `docs/execution-results/redacted-newman/run-001/newman.html` | `fb11f55313141d085f9108b9443aefca4b07c82fc2e0487c48c8381b372a3786` | `c64a23eb47ecb8eefd9fa5294b3a0b15249b70e4317944188e4a1da1f520e024` | AUTHORIZATION: 7, JWT: 4, PASSWORD: 11, POSTMAN_TOKEN: 103, RESET_TOKEN: 4, STUDENT_ID: 1 |
| `test-results/hw06/run-001/newman.json` | `docs/execution-results/redacted-newman/run-001/newman.json` | `a27b90669a98e4fed773f30c31985bbfaaaa0e9ece49d5fb490a0d3a20aa1db1` | `940382d892fdcace78c64c454026e71a7dac8f4e2f7ecbc77db46532e4407b42` | AUTHORIZATION: 9, JWT: 4, PASSWORD: 16, POSTMAN_TOKEN: 103, RESET_TOKEN: 10, STUDENT_ID: 2, TOKEN: 3 |
| `test-results/hw06/run-001/external-postcheck.newman.json` | `docs/execution-results/redacted-newman/run-001/external-postcheck.newman.json` | `23d5cddbe5daa511e1f8527c37629af0a121ff90610940f17242843178208904` | `6d91bd96ff7ce991cfa752f2b7354571fda0a06bb58979554ea2a5b0db77df20` | AUTHORIZATION: 2, JWT: 3, PASSWORD: 5, POSTMAN_TOKEN: 2, RESET_TOKEN: 2, STUDENT_ID: 2, TOKEN: 2 |
| `test-results/hw06/run-002/newman.html` | `docs/execution-results/redacted-newman/run-002/newman.html` | `962796298c5e39612e495fa44b94347989442a398c082773c642e4e22b0c1f4e` | `27f36851c1ab9a9c78a82d1a30aecd1cc7ee47d37e866b881bf199774781bd7a` | AUTHORIZATION: 20, JWT: 18, PASSWORD: 11, POSTMAN_TOKEN: 179, RESET_TOKEN: 22, STUDENT_ID: 1 |
| `test-results/hw06/run-002/newman.json` | `docs/execution-results/redacted-newman/run-002/newman.json` | `2fcea3f78a0ad148cc6ab912360ba509a554b2f5c49977588f0c7d45bb5892be` | `5b52e570f5901ffa808cfe412aa49851f88ea538414a32a82c2f9bce1cec8dc0` | AUTHORIZATION: 20, JWT: 19, PASSWORD: 17, POSTMAN_TOKEN: 179, RESET_TOKEN: 45, STUDENT_ID: 2, TOKEN: 20 |

The final package must include these redacted derivatives rather than the token-bearing raw `newman.html`/`newman.json` files. This does not alter the preserved historical execution artifacts.
