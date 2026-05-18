# frozen_string_literal: true

module SduSmart
  class Annotation < Lutaml::Model::Serializable
    attribute :id, :string
    attribute :has_target, :string
    attribute :has_body, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                SduSmart::Rdf::Namespaces::OaNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "oa:Annotation"

      predicate :hasTarget,
                namespace: SduSmart::Rdf::Namespaces::OaNamespace,
                to: :has_target

      predicate :hasBody,
                namespace: SduSmart::Rdf::Namespaces::OaNamespace,
                to: :has_body
    end
  end
end
