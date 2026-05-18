# frozen_string_literal: true

module SduSmart
  class Entity < Lutaml::Model::Serializable
    attribute :id, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Entity"
    end
  end
end
