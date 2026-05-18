# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

`sdu_smart` is a standalone Ruby gem providing the SmartSDU Core Ontology information model. It was extracted from the `isq-smart` monorepo (the `sdu-smart/` subdirectory). Domain gems like `isq` depend on this gem and extend `TermEntry` with domain-specific subclasses.

All model classes inherit from `Lutaml::Model::Serializable` and declare RDF mappings via `rdf do` blocks supporting Turtle and JSON-LD serialization. Entity subclasses and non-Entity model classes (Annotation, SpecificResource, Selector, Derivation) both declare `id` attributes and RDF subject patterns.

## Commands

```bash
bundle install                    # install dependencies
bundle exec rspec                 # run all specs
bundle exec rspec spec/sdu_smart/entity_spec.rb  # single spec file
bundle exec rspec spec/sdu_smart/entity_spec.rb:54  # single example (by line)
bundle exec rake spec             # run specs via Rake
```

## Architecture

### Base class: `Entity`

`SduSmart::Entity` (`lib/sdu_smart/entity.rb`) is the root of the hierarchy. Every class inherits from it either directly or transitively. It declares `attribute :id, :string` and sets up the base RDF subject pattern:

```
https://w3id.org/standards/smart/ontologies/core/{id}
```

The `id` is only used in the subject URI — it is NOT mapped to `dcterms:title`. Only `Clause` maps its `title` attribute to `dcterms:title`.

### lutaml-model RDF subclass behavior

Subclass `rdf do` blocks **replace** (not merge with) parent `rdf do` blocks. This means provision subtypes (Statement, Requirement, etc.) only output their `rdf:type` in Turtle — they don't serialize inherited predicates like `hasBindingnessType`. To serialize/deserialize provision predicates, use the `Provision` base class directly.

### Entity hierarchy

- **Provision** (abstract) — 8 concrete subtypes in `lib/sdu_smart/provision/`, each with its own `rdf:type` (e.g. `smart:Statement`, `smart:Requirement`). Subtypes share the same attribute set but differ in RDF type. Has `dcat:distribution` for linking to distribution resources.
- **ProvisionSet → Clause** — `Clause` adds section/title/bindingness attributes.
- **ProvisionSupplement** — note, example, footnote supplements.
- **TermEntry** — designed to be subclassed by domain gems (e.g. `Isq::Quantity`, `Isq::Unit`, `Isq::MathConcept`). Has `skos:definition`, `dcterms:identifier`, `skos:scopeNote`, `skosxl:prefLabel`, `skosxl:altLabel`, `smart:deprecatedLabel`, `prov:qualifiedDerivation`.
- **Term** — SKOS-XL label with pronunciation, country, part-of-speech, and term form.
- **PublicationDocument** — document metadata with publication type, issued date, versions.
- **Agent → Organization** — minimal agent model.
- **Activity** — minimal activity model.

### Non-Entity model classes

These inherit directly from `Lutaml::Model::Serializable` (not `Entity`), since their RDF types use non-smart namespaces:

- **Annotation** (`oa:Annotation`) — links a target (SpecificResource) to a body (Provision).
- **SpecificResource** (`oa:SpecificResource`) — references a source document, selector, with optional successor chain, value, and format.
- **Selector** (`oa:Selector`) — holds an `rdf:value` for identifying a fragment.
- **Derivation** (`prov:Derivation`) — tracks term provenance with `prov:entity` and `skos:changeNote`.

### Taxonomy classes

`SduSmart::Taxonomy` contains SKOS concept classes. All inherit from `SduSmart::Taxonomy::Concept` (not `Entity`), which provides the `taxonomy` macro:

```ruby
class BindingnessType < Concept
  taxonomy "BindingnessType",
           values: %w[normative informative],
           subject_path: "bindingness-type"
end
```

The `taxonomy` macro declares `VALUES`, sets up the RDF subject/type/predicate mapping. Concept also provides `.fetch(label)` — a factory that validates against `VALUES` and raises `ArgumentError` with the valid set on invalid input.

Taxonomy types: `BindingnessType`, `ProvisionType`, `PublicationComponentType`, `PublicationDocumentType`, `ProvisionSupplementType`, `PartOfSpeechType`, `TermFormType`.

To add a new taxonomy, create a subclass of `Concept` and call the `taxonomy` macro.

### RDF namespaces

Defined in `lib/sdu_smart/rdf/namespaces/`. Each namespace is a `Lutaml::Rdf::Namespace` subclass with `uri` and `prefix` class methods:
- `SmartNamespace` — `smart:` → `https://w3id.org/standards/smart/ontologies/core/`
- `IsoIec80000Namespace` — `isoiec80000:` → `https://w3id.org/standards/isoiec80000/ontologies/core/`
- `OaNamespace` — `oa:` → `http://www.w3.org/ns/oa#`
- `DcatNamespace` — `dcat:` → `http://www.w3.org/ns/dcat#`
- `ProvNamespace` — `prov:` → `http://www.w3.org/ns/prov#`
- `SkosXlNamespace` — `skosxl:` → `http://www.w3.org/2008/05/skos-xl#`

### Autoload pattern

`lib/sdu_smart.rb` uses Ruby `autoload` for all constants. Sub-namespaces (`Provision`, `Taxonomy`, `Rdf::Namespaces`) also use `autoload` in their parent files.

## Ontology compliance

`reference-docs/smartsdu-information-model-share-c6362d946900/` contains the authoritative SmartSDU information model. Key files:
- `information_model/ontologies/core-ontology.ttl` — class and property definitions
- `information_model/schemas/shacl/core-ontology.shacl.ttl` — SHACL shapes for entities
- `information_model/schemas/shacl/terminology-model.shacl.ttl` — SHACL for TermEntry/Term
- `information_model/schemas/shacl/annotation-ontology.shacl.ttl` — annotation model (Annotation, SpecificResource, Selector)
- `information_model/taxonomies/*.ttl` — SKOS taxonomy instances

Specs verify compliance: class hierarchy, RDF types, predicate names, taxonomy VALUES, subject URI patterns, and round-trip serialization.

### Ontology gaps

All gaps from the authoritative ontology have been implemented. See specs for full coverage.

## Dependencies

- `lutaml-model ~> 0.8.0` — serialization framework (JSON, XML, YAML, TOML, RDF)
- Development: `rdf-turtle ~> 3.3`, `rake`, `rspec`
