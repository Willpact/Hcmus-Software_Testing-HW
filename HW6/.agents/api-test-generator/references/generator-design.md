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

## Textual layout suggestion for a student-drawn diagram

Use a left-to-right flow of five boxes: `Specification reader`, `Analysis modules`, `Candidate builder`, `Deduplication`, `Coverage + Human review`. Put the six analysis techniques inside or beneath `Analysis modules`. This is a textual aid only; it is not a submission-ready diagram.
