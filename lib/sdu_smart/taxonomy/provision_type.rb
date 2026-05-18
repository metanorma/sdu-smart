# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class ProvisionType < Concept
      taxonomy "ProvisionType",
               values: %w[governingProvision assertionalProvision],
               subject_path: "provision-type"
    end
  end
end
