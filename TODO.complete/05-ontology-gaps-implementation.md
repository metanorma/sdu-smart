# 05 — Implement all ontology gaps

## New namespaces
- `DcatNamespace` — `dcat:` → `http://www.w3.org/ns/dcat#`
- `ProvNamespace` — `prov:` → `http://www.w3.org/ns/prov#`
- `SkosXlNamespace` — `skosxl:` → `http://www.w3.org/2008/05/skos-xl#`

## New entity classes (inherit from Serializable, not Entity)
- `SduSmart::Annotation` — `oa:Annotation`, predicates: `oa:hasTarget`, `oa:hasBody`
- `SduSmart::SpecificResource` — `oa:SpecificResource`, predicates: `oa:hasSource`, `oa:hasSelector`, `smart:isSuccessorOf`, `rdf:value`, `dcterms:format`
- `SduSmart::Selector` — `oa:Selector`, predicates: `rdf:value`
- `SduSmart::Derivation` — `prov:Derivation`, predicates: `prov:entity`, `skos:changeNote`

## Updated classes
- `Provision` — added `dcat:distribution` (collection)
- `TermEntry` — added `skos:definition`, `dcterms:identifier`, `skos:scopeNote`, `smart:deprecatedLabel`, `skosxl:prefLabel`, `skosxl:altLabel`, `prov:qualifiedDerivation`

## Ontology properties not modeled (by design)
- `dcterms:hasPart` — inverse of `isPartOf`, implicit from existing `isPartOf` data
- `dcterms:references` — declared in ontology but no SHACL shape constrains its usage

## Specs
- 227 examples, 0 failures
- New annotation_spec.rb: 20 examples for Annotation, SpecificResource, Selector, Derivation
- Updated entity_spec.rb: 7 new TermEntry predicate tests, 1 new Provision test
- Updated class_hierarchy_spec.rb: 8 new tests for non-Entity model classes
- Updated rdf_namespaces_spec.rb: 6 new tests for Dcat, Prov, SkosXl namespaces
- Updated turtle_round_trip_spec.rb: 7 new round-trip tests
