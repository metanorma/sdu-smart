# frozen_string_literal: true

require_relative "lib/sdu_smart/version"

Gem::Specification.new do |spec|
  spec.name = "sdu_smart"
  spec.version = SduSmart::VERSION
  spec.authors = ["Ribose"]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "SmartSDU Core Ontology — Lutaml-model classes with RDF serialization."
  spec.description = "Ruby gem providing the SmartSDU Core Ontology information model. " \
                     "Includes Entity, Provision, TermEntry, PublicationDocument, " \
                     "SKOS taxonomy instances, and RDF namespace modules. " \
                     "Built on lutaml-model with Turtle and JSON-LD serialization support."

  spec.homepage = "https://github.com/metanorma/sdu-smart"
  spec.license = "BSD-2-Clause"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob("lib/**/*.rb")
  spec.bindir = "exe"
  spec.executables = []
  spec.require_paths = ["lib"]

  spec.add_dependency "lutaml-model", "~> 0.8.0"
end
