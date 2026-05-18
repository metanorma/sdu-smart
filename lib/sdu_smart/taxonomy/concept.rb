# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class Concept < Lutaml::Model::Serializable
      attribute :label, :string

      class << self
        def taxonomy(rdf_type, values:, subject_path:)
          const_set(:VALUES, values.freeze)

          rdf do
            namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                      Lutaml::Rdf::Namespaces::SkosNamespace

            subject { |m| "https://w3id.org/standards/smart/taxonomies/#{subject_path}/#{m.label}" }

            type "smart:#{rdf_type}"

            predicate :prefLabel,
                      namespace: Lutaml::Rdf::Namespaces::SkosNamespace,
                      to: :label
          end
        end

        def fetch(label)
          unless self::VALUES.include?(label)
            raise ArgumentError, "#{name}: invalid value '#{label}'. Valid: #{self::VALUES.join(', ')}"
          end

          new(label: label)
        end

        def inherited(subclass)
          super
        end
      end
    end
  end
end
