# frozen_string_literal: true

require "lutaml/model"
require "lutaml/turtle"
require "lutaml/jsonld"

require_relative "sdu_smart/version"

module SduSmart
  autoload :Entity, "#{__dir__}/sdu_smart/entity"
  autoload :Activity, "#{__dir__}/sdu_smart/activity"
  autoload :Agent, "#{__dir__}/sdu_smart/agent"
  autoload :Organization, "#{__dir__}/sdu_smart/organization"
  autoload :Provision, "#{__dir__}/sdu_smart/provision"
  autoload :ProvisionSet, "#{__dir__}/sdu_smart/provision_set"
  autoload :Clause, "#{__dir__}/sdu_smart/clause"
  autoload :ProvisionSupplement, "#{__dir__}/sdu_smart/provision_supplement"
  autoload :Term, "#{__dir__}/sdu_smart/term"
  autoload :TermEntry, "#{__dir__}/sdu_smart/term_entry"
  autoload :PublicationDocument, "#{__dir__}/sdu_smart/publication_document"
  autoload :Taxonomy, "#{__dir__}/sdu_smart/taxonomy"
  autoload :Rdf, "#{__dir__}/sdu_smart/rdf"
end
