# 03 — Comprehensive spec suite

## Problem
All specs in one monolithic file (78 examples in `core_classes_spec.rb`).
No shared examples for taxonomy or entity patterns. No validation tests.

## Spec structure

```
spec/
  spec_helper.rb
  sdu_smart/
    class_hierarchy_spec.rb        — all 11 inheritance relationships
    entity_spec.rb                 — Entity base + all concrete entity classes
    taxonomy_spec.rb               — Taxonomy::Concept base + all 7 taxonomies
    rdf_namespaces_spec.rb         — 3 namespace classes
    turtle_round_trip_spec.rb      — serialization round-trips
```

### Shared examples
- `behaves_like a_taxonomy_concept` — VALUES constant, factory method, subject
  URI pattern, rdf:type, skos:prefLabel, base class
- `behaves_like an_entity` — inherits from Entity, has id, subject URI,
  correct rdf:type

### Coverage requirements
- Every class: hierarchy, rdf:type, predicates, subject URI
- Every taxonomy: VALUES match ontology, factory `[]`, validation, subject URI
- Round-trip: all entity classes with predicates
- No `send` or `respond_to?` usage
- No private method access
