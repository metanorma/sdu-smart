# frozen_string_literal: true

module SduSmart
  class Entity < Lutaml::Model::Serializable
    attribute :id, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                Lutaml::Rdf::Namespaces::DctermsNamespace,
                Lutaml::Rdf::Namespaces::SkosNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Entity"

      predicate :title,
                namespace: Lutaml::Rdf::Namespaces::DctermsNamespace,
                to: :id
    end
  end
end
