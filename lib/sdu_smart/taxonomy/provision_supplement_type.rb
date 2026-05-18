# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class ProvisionSupplementType < Concept
      taxonomy "ProvisionSupplementType",
               values: %w[example footnote note],
               subject_path: "provision-supplement-type"
    end
  end
end
