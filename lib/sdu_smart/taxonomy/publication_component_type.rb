# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class PublicationComponentType < Lutaml::Model::Serializable
      attribute :label, :string

      VALUES = %w[code figure mathematicalFormula table textual].freeze

      rdf do
        namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                  Lutaml::Rdf::Namespaces::SkosNamespace

        subject { |m| "https://w3id.org/standards/smart/taxonomies/publication-component-type/#{m.label}" }

        type "smart:PublicationComponentType"

        predicate :prefLabel,
                  namespace: Lutaml::Rdf::Namespaces::SkosNamespace,
                  to: :label
      end
    end
  end
end
