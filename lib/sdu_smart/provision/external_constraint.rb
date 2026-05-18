# frozen_string_literal: true

module SduSmart
  class ExternalConstraint < Provision
    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:ExternalConstraint"
    end
  end
end
