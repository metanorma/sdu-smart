# frozen_string_literal: true

module SduSmart
  class SpecificResource < Lutaml::Model::Serializable
    attribute :id, :string
    attribute :has_source, :string
    attribute :has_selector, :string
    attribute :is_successor_of, :string
    attribute :value, :string
    attribute :format, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                SduSmart::Rdf::Namespaces::OaNamespace,
                Lutaml::Rdf::Namespaces::DctermsNamespace,
                Lutaml::Rdf::Namespaces::RdfNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "oa:SpecificResource"

      predicate :hasSource,
                namespace: SduSmart::Rdf::Namespaces::OaNamespace,
                to: :has_source

      predicate :hasSelector,
                namespace: SduSmart::Rdf::Namespaces::OaNamespace,
                to: :has_selector

      predicate :isSuccessorOf,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :is_successor_of

      predicate :value,
                namespace: Lutaml::Rdf::Namespaces::RdfNamespace,
                to: :value

      predicate :format,
                namespace: Lutaml::Rdf::Namespaces::DctermsNamespace,
                to: :format
    end
  end
end
