# frozen_string_literal: true

module SduSmart
  class TermEntry < Entity
    attribute :bindingness_type, :string
    attribute :is_part_of, :string
    attribute :definition, :string
    attribute :identifier, :string
    attribute :scope_note, :string
    attribute :deprecated_label, :string, collection: true
    attribute :pref_label, :string, collection: true
    attribute :alt_label, :string, collection: true
    attribute :qualified_derivation, :string, collection: true

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                Lutaml::Rdf::Namespaces::DctermsNamespace,
                Lutaml::Rdf::Namespaces::SkosNamespace,
                SduSmart::Rdf::Namespaces::SkosXlNamespace,
                SduSmart::Rdf::Namespaces::ProvNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:TermEntry"

      predicate :hasBindingnessType,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :bindingness_type

      predicate :isPartOf,
                namespace: Lutaml::Rdf::Namespaces::DctermsNamespace,
                to: :is_part_of

      predicate :definition,
                namespace: Lutaml::Rdf::Namespaces::SkosNamespace,
                to: :definition,
                lang_tagged: true

      predicate :identifier,
                namespace: Lutaml::Rdf::Namespaces::DctermsNamespace,
                to: :identifier

      predicate :scopeNote,
                namespace: Lutaml::Rdf::Namespaces::SkosNamespace,
                to: :scope_note,
                lang_tagged: true

      predicate :deprecatedLabel,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :deprecated_label,
                uri_reference: true

      predicate :prefLabel,
                namespace: SduSmart::Rdf::Namespaces::SkosXlNamespace,
                to: :pref_label,
                uri_reference: true

      predicate :altLabel,
                namespace: SduSmart::Rdf::Namespaces::SkosXlNamespace,
                to: :alt_label,
                uri_reference: true

      predicate :qualifiedDerivation,
                namespace: SduSmart::Rdf::Namespaces::ProvNamespace,
                to: :qualified_derivation,
                uri_reference: true
    end
  end
end
