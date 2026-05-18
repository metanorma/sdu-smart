# frozen_string_literal: true

module SduSmart
  class Clause < ProvisionSet
    attribute :bindingness_type, :string
    attribute :section_number, :string
    attribute :title, :string
    attribute :is_part_of, :string
    attribute :is_successor_of, :string

    rdf do
      namespace SduSmart::Rdf::Namespaces::SmartNamespace,
                Lutaml::Rdf::Namespaces::DctermsNamespace

      subject { |m| "https://w3id.org/standards/smart/ontologies/core/#{m.id}" }

      type "smart:Clause"

      predicate :hasBindingnessType,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :bindingness_type

      predicate :hasSectionNumber,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :section_number

      predicate :title,
                namespace: Lutaml::Rdf::Namespaces::DctermsNamespace,
                to: :title

      predicate :isPartOf,
                namespace: Lutaml::Rdf::Namespaces::DctermsNamespace,
                to: :is_part_of

      predicate :isSuccessorOf,
                namespace: SduSmart::Rdf::Namespaces::SmartNamespace,
                to: :is_successor_of
    end
  end
end
