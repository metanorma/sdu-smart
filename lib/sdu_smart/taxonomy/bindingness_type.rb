# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class BindingnessType < Concept
      taxonomy "BindingnessType",
               values: %w[normative informative],
               subject_path: "bindingness-type"
    end
  end
end
