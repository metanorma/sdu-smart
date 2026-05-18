# frozen_string_literal: true

require "bundler/setup"
require "sdu_smart"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
end

RSpec.shared_examples "a taxonomy concept" do |rdf_type:, values:, subject_path:|
  it "inherits from Taxonomy::Concept" do
    expect(described_class).to be < SduSmart::Taxonomy::Concept
  end

  it "is not an Entity" do
    expect(described_class).not_to be < SduSmart::Entity
  end

  it "has correct VALUES matching ontology" do
    expect(described_class::VALUES).to contain_exactly(*values)
  end

  it "serializes with correct rdf:type" do
    instance = described_class.new(label: values.first)
    expect(instance.to_turtle).to include("a smart:#{rdf_type}")
  end

  it "uses skos:prefLabel predicate" do
    instance = described_class.new(label: values.first)
    expect(instance.to_turtle).to include("skos:prefLabel")
  end

  it "uses correct subject URI path" do
    instance = described_class.new(label: values.first)
    expect(instance.to_turtle).to include("taxonomies/#{subject_path}/#{values.first}")
  end

  describe ".fetch" do
    it "returns an instance for a valid label" do
      instance = described_class.fetch(values.first)
      expect(instance.label).to eq(values.first)
    end

    it "raises ArgumentError for an invalid label" do
      expect { described_class.fetch("nonexistent") }.to raise_error(ArgumentError)
    end

    it "includes valid values in error message" do
      expect { described_class.fetch("nonexistent") }.to raise_error(/Valid:.*#{values.first}/)
    end
  end
end

RSpec.shared_examples "an entity subclass" do |rdf_type:|
  it "inherits from Entity" do
    expect(described_class).to be < SduSmart::Entity
  end

  it "has an id attribute" do
    instance = described_class.new(id: "test")
    expect(instance.id).to eq("test")
  end

  it "includes id in subject URI" do
    instance = described_class.new(id: "test-id")
    expect(instance.to_turtle).to include("test-id")
  end

  it "serializes with correct rdf:type" do
    instance = described_class.new(id: "test")
    expect(instance.to_turtle).to include("a smart:#{rdf_type}")
  end
end
