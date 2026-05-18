# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class PublicationComponentType < Concept
      taxonomy "PublicationComponentType",
               values: %w[code figure mathematicalFormula table textual],
               subject_path: "publication-component-type"
    end
  end
end
