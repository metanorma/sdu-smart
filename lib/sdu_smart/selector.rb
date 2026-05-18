# frozen_string_literal: true

module SduSmart
  class Selector < Lutaml::Model::Serializable
    attribute :id, :string
    attribute :value, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                SduSmart::Rdf::Namespaces::OaNamespace,
                Lutaml::Rdf::Namespaces::RdfNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "oa:Selector"

      predicate :value,
                namespace: Lutaml::Rdf::Namespaces::RdfNamespace,
                to: :value
    end
  end
end
