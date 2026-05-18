# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class PublicationDocumentType < Concept
      taxonomy "PublicationDocumentType",
               values: %w[
                 guide publiclyAvailableSpecification technicalReport
                 technicalSpecification normativeDocument standard
                 internationalStandard
               ],
               subject_path: "publication-type"
    end
  end
end
