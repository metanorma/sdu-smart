# 06 — Full ontology audit

## Audit scope

Systematic comparison of every authoritative source file against the Ruby implementation:
- `core-ontology.ttl` — 26 owl:Class, 13 ObjectProperty, 2 DatatypeProperty
- `core-ontology.shacl.ttl` — PublicationDocumentShape, ProvisionShape, ClauseShape
- `terminology-model.shacl.ttl` — TermEntryShape, TermShape, DerivationShape
- `annotation-ontology.shacl.ttl` — AnnotationShape, SpecificResourceShape, SelectorShape
- 7 taxonomy TTL files — concept instances and VALUES
- 4 sample TTL files — usage patterns (annotations, terms, document reconstruction, versioning)

## Verified matching (no action needed)

- All 26 owl:Class definitions → Ruby classes exist
- All 8 provision subtypes → subclasses of Provision with correct rdf:type
- All 7 taxonomy VALUES match TTL concept local names exactly
- All subject URI patterns match TTL prefix declarations
- All rdf:type strings match
- All predicate names match core-ontology and SHACL shapes
- Class hierarchy matches rdfs:subClassOf
- PublicationDocument: hasVersion, replaces, issued ✓
- Provision: isPartOf, dcat:distribution, bindingness, provisionType, publicationComponentType, hasSupplement ✓
- Clause: hasSectionNumber, dcterms:title, isPartOf, hasBindingnessType, isSuccessorOf ✓
- TermEntry: definition, identifier, scopeNote, prefLabel, altLabel, deprecatedLabel, qualifiedDerivation ✓
- Term: pronunciation, hasPartOfSpeechType, hasTermFormType ✓
- ProvisionSupplement: hasSupplementType, hasBindingnessType, hasPublicationComponentType ✓
- Annotation: hasTarget, hasBody ✓
- SpecificResource: hasSource, hasSelector, isSuccessorOf, value, format ✓
- Selector: value ✓
- Derivation: entity, changeNote ✓
- Taxonomy Concept: prefLabel, VALUES, subject URI pattern, fetch factory ✓
- All 6 namespaces: smart, isoiec80000, oa, dcat, prov, skosxl ✓

## Bugs found and fixed

### 1. Term#used_in_country should be collection

`smart:usedInCountry` is a DatatypeProperty without `owl:FunctionalProperty`.
The terms sample shows multiple values: `smart:usedInCountry "GB", "US"`.
Changed from `:string` to `:string, collection: true`.

### 2. Term missing skosxl:literalForm

All term samples show `skosxl:literalForm` on Term (e.g. `"intended use"@en`).
This is the fundamental SKOS-XL property for the term's display text.
The terminology-model.shacl references the path `(skosxl:prefLabel skosxl:literalForm)`
which traverses TermEntry → Term → literalForm.
Added `literal_form` attribute mapped to `skosxl:literalForm`.

## Not modeled (by design, outside gem scope)

These appear only in sample TTLs, not in SHACL shapes:
- `dcat:Distribution` properties (mediaType, byteSize, downloadURL) on SpecificResource — multi-type pattern
- `spdx:Checksum` — external provenance vocabulary
- `dcterms:hasPart` — inverse of isPartOf, derivable from existing data
- `dcterms:references` — declared in ontology with no SHACL constraints
- `oa:XPathSelector` — subtypes of Selector are not modeled; Selector covers the base case
