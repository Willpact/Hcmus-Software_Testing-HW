# Reusable generator design

## Components

1. **Specification reader** records source locations and separates authoritative requirements from supporting context and implementation observations.
2. **Analyzer set** derives parameter domains, boundaries, state transitions, security contexts, schema assertions, and business-rule conditions.
3. **Candidate builder** creates canonical-schema draft cases with stable provisional IDs and requirement traceability.
4. **Deduplicator** compares deterministic behavioral fingerprints, preserving provenance for merged candidates.
5. **Coverage checker** maps requirements and techniques to candidates, reports gaps, and emits a human-review checkpoint.

## Pseudocode

```text
extract = read_and_label(specification, supporting_sources)
if extract.authoritative_conflicts: return clarification_checkpoint(extract)

conditions = union(
  domains(extract), boundaries(extract), states(extract),
  security_contexts(extract), schemas(extract), business_rules(extract)
)
candidates = map(conditions, make_canonical_draft_case)
unique = deduplicate(candidates, behavioral_fingerprint)
coverage = map_requirements_and_techniques(extract, unique)
return { cases: unique, coverage: coverage, checkpoint: GENERATOR_OUTPUT_REVIEW_REQUIRED }
```

## Final Human-created diagram

The completed Human-controlled final artifact is [api-test-generator-diagram.png](../../../docs/agent-skill/api-test-generator-diagram.png). It was created/exported by the student using Mermaid.io and is integrated into the final HW06 report. This document retains the design rationale and pseudocode; it does not generate or alter the diagram.

## Textual layout suggestion for the Human-created diagram

The completed figure follows a left-to-right logical flow of `Specification reader`, `Analysis modules`, `Candidate builder`, `Deduplication`, and `Coverage + Human review`. The six analysis techniques are shown inside `Analysis modules`. This textual rationale is retained for traceability; the PNG is the Human-created submission artifact.
