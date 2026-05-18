# frozen_string_literal: true

module SduSmart
  module Taxonomy
    class PartOfSpeechType < Concept
      taxonomy "PartOfSpeechType",
               values: %w[adjective adverb noun verb],
               subject_path: "part-of-speech-type"
    end
  end
end
