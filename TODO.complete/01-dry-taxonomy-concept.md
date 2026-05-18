# 01 — DRY: Extract Taxonomy::Concept base class

## Problem

All 7 taxonomy classes are 100% identical except class name, VALUES, rdf:type,
and subject path segment. That's 175 lines of near-identical code (7 × 25 lines).

```ruby
# Current: repeated in every taxonomy file
class BindingnessType < Lutaml::Model::Serializable
  attribute :label, :string
  VALUES = %w[normative informative].freeze
  rdf do
    namespace SduSmart::Rdf::Namespaces::SmartNamespace,
              Lutaml::Rdf::Namespaces::SkosNamespace
    subject { |m| "https://w3id.org/standards/smart/taxonomies/bindingness-type/#{m.label}" }
    type "smart:BindingnessType"
    predicate :prefLabel,
              namespace: Lutaml::Rdf::Namespaces::SkosNamespace,
              to: :label
  end
end
```

## Solution

Create `Taxonomy::Concept` base class that encapsulates the shared pattern.
Each taxonomy becomes a 3-field declaration.

```ruby
# After: only the differences
class BindingnessType < Concept
  taxonomy "BindingnessType",
           values: %w[normative informative],
           subject_path: "bindingness-type"
end
```

### Features added:
- `self.[](label)` factory method with VALUES validation
- `self.values` accessor
- Validation on initialization if label not in VALUES

## Files changed
- NEW: `lib/sdu_smart/taxonomy/concept.rb`
- MODIFY: all 7 taxonomy files (25 lines → ~7 lines each)
- MODIFY: `lib/sdu_smart/taxonomy.rb` (add autoload for Concept)
