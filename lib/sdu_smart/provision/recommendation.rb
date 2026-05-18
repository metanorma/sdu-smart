# frozen_string_literal: true

module SduSmart
  class Recommendation < Provision
    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Recommendation"
    end
  end
end
