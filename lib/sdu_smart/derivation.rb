# frozen_string_literal: true

module SduSmart
  class Derivation < Lutaml::Model::Serializable
    attribute :id, :string
    attribute :entity, :string
    attribute :change_note, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                SduSmart::Rdf::Namespaces::ProvNamespace,
                Lutaml::Rdf::Namespaces::SkosNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "prov:Derivation"

      predicate :entity,
                namespace: SduSmart::Rdf::Namespaces::ProvNamespace,
                to: :entity

      predicate :changeNote,
                namespace: Lutaml::Rdf::Namespaces::SkosNamespace,
                to: :change_note
    end
  end
end
