# frozen_string_literal: true

module SduSmart
  class Activity < Entity
    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Activity"
    end
  end
end
