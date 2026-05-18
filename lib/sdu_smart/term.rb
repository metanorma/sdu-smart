# frozen_string_literal: true

module SduSmart
  class Term < Entity
    attribute :pronunciation, :string
    attribute :used_in_country, :string, collection: true
    attribute :part_of_speech_type, :string
    attribute :term_form_type, :string
    attribute :literal_form, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                SduSmart::Rdf::Namespaces::SkosXlNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Term"

      predicate :pronunciation,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :pronunciation

      predicate :usedInCountry,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :used_in_country

      predicate :hasPartOfSpeechType,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :part_of_speech_type

      predicate :hasTermFormType,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :term_form_type

      predicate :literalForm,
                namespace: SduSmart::Rdf::Namespaces::SkosXlNamespace,
                to: :literal_form
    end
  end
end
