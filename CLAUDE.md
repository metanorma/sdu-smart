# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

`sdu_smart` is a standalone Ruby gem providing the SmartSDU Core Ontology information model. It was extracted from the `isq-smart` monorepo (the `sdu-smart/` subdirectory). Domain gems like `isq` depend on this gem and extend `TermEntry` with domain-specific subclasses.

All model classes inherit from `Lutaml::Model::Serializable` and declare RDF mappings via `rdf do` blocks supporting Turtle and JSON-LD serialization.

## Commands

```bash
bundle install                    # install dependencies
bundle exec rspec                 # run all specs
bundle exec rspec spec/sdu_smart/core_classes_spec.rb  # single spec file
bundle exec rspec spec/sdu_smart/core_classes_spec.rb:54  # single example (by line)
bundle exec rake spec             # run specs via Rake
```

## Architecture

### Base class: `Entity`

`SduSmart::Entity` (`lib/sdu_smart/entity.rb`) is the root of the hierarchy. Every class inherits from it either directly or transitively. It declares `attribute :id, :string` and sets up the base RDF subject pattern:

```
https://w3id.org/standards/smart/ontologies/core/{id}
```

### Entity hierarchy

- **Provision** (abstract) — 8 concrete subtypes in `lib/sdu_smart/provision/`, each with its own `rdf:type` (e.g. `smart:Statement`, `smart:Requirement`). Subtypes share the same attribute set but differ in RDF type.
- **ProvisionSet → Clause** — `Clause` adds section/title/bindingness attributes.
- **ProvisionSupplement** — note, example, footnote supplements.
- **TermEntry** — designed to be subclassed by domain gems (e.g. `Isq::Quantity`, `Isq::Unit`, `Isq::MathConcept`). Has `bindingness_type` and `is_part_of`.
- **Term** — SKOS-XL label with pronunciation, country, part-of-speech, and term form.
- **PublicationDocument** — document metadata with publication type, issued date, versions.
- **Agent → Organization** — minimal agent model.
- **Activity** — minimal activity model.

### Taxonomy classes

`SduSmart::Taxonomy` contains SKOS concept classes. Each one:
- Inherits directly from `Lutaml::Model::Serializable` (not `Entity`)
- Declares a `VALUES` constant listing valid concept labels
- Uses `skos:prefLabel` for the label predicate
- Has a subject pattern under `https://w3id.org/standards/smart/taxonomies/{type}/{label}`

Taxonomy types: `BindingnessType`, `ProvisionType`, `PublicationComponentType`, `PublicationDocumentType`, `ProvisionSupplementType`, `PartOfSpeechType`, `TermFormType`.

### RDF namespaces

Defined in `lib/sdu_smart/rdf/namespaces/`. Each namespace is a `Lutaml::Rdf::Namespace` subclass with `uri` and `prefix` class methods:
- `SmartNamespace` — `smart:` → `https://w3id.org/standards/smart/ontologies/core/`
- `IsoIec80000Namespace` — `isoiec80000:` → `https://w3id.org/standards/isoiec80000/ontologies/core/`
- `OaNamespace` — `oa:` → `http://www.w3.org/ns/oa#`

### Autoload pattern

`lib/sdu_smart.rb` uses Ruby `autoload` for all constants. Sub-namespaces (`Provision`, `Taxonomy`, `Rdf::Namespaces`) also use `autoload` in their parent files.

## Dependencies

- `lutaml-model ~> 0.8.0` — serialization framework (JSON, XML, YAML, TOML, RDF)
- Development: `rdf-turtle ~> 3.3`, `rake`, `rspec`

## Reference docs

`reference-docs/smartsdu-information-model-share-c6362d946900/` contains the authoritative SmartSDU information model: OWL ontology, SHACL shapes, and SKOS taxonomies in Turtle format. Use it to verify RDF predicate and class design matches the specification.
