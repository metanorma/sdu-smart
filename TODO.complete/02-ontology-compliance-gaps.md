# 02 — Ontology compliance gaps

## Verified matching (no action needed)
- All 26 owl:Class definitions → Ruby classes exist ✓
- All 8 provision subtypes → subclasses of Provision ✓
- All taxonomy VALUES match TTL files ✓
- All subject URI patterns match ✓
- All rdf:type strings match ✓
- All predicate names match ✓
- Class hierarchy matches rdfs:subClassOf ✓

## Remaining gaps (not yet modeled, deferred to domain gems / future)
- `dcat:distribution` on Provision (SHACL shape)
- `dcterms:references` (owl:ObjectProperty, not used in any SHACL shape)
- `smart:deprecatedLabel` (owl:ObjectProperty on TermEntry)
- TermEntry SHACL properties: `skos:definition`, `dcterms:identifier`, `skos:scopeNote`
- Annotation model: `oa:Annotation`, `oa:SpecificResource`, `oa:Selector`
- Derivation model: `prov:Derivation`
- `dcterms:hasPart` (inverse of isPartOf)

## Action
Document gaps in CLAUDE.md as future scope. No implementation changes — these
are either annotation/provenance concerns or deferred to domain gems.
