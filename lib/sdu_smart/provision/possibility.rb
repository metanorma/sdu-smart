# frozen_string_literal: true

module SduSmart
  class Possibility < Provision
    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Possibility"
    end
  end
end
