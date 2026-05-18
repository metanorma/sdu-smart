# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class TermFormType < Concept
      taxonomy "TermFormType",
               values: %w[abbreviation acronym equation formula fullForm symbol variant],
               subject_path: "term-form-type"
    end
  end
end
