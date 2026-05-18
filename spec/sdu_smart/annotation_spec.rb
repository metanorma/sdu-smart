# frozen_string_literal: true

RSpec.describe SduSmart::Annotation do
  it "inherits from Lutaml::Model::Serializable" do
    expect(described_class).to be < Lutaml::Model::Serializable
  end

  it "does not inherit from Entity" do
    expect(described_class).not_to be < SduSmart::Entity
  end

  it "has an id attribute" do
    expect(described_class.new(id: "ann-1").id).to eq("ann-1")
  end

  it "serializes with oa:Annotation type" do
    expect(described_class.new(id: "ann-1").to_turtle).to include("a oa:Annotation")
  end

  it "maps has_target to oa:hasTarget" do
    ann = described_class.new(id: "ann-1", has_target: "sr-1")
    expect(ann.to_turtle).to include("oa:hasTarget")
  end

  it "maps has_body to oa:hasBody" do
    ann = described_class.new(id: "ann-1", has_body: "prov-1")
    expect(ann.to_turtle).to include("oa:hasBody")
  end
end

RSpec.describe SduSmart::SpecificResource do
  it "inherits from Lutaml::Model::Serializable" do
    expect(described_class).to be < Lutaml::Model::Serializable
  end

  it "does not inherit from Entity" do
    expect(described_class).not_to be < SduSmart::Entity
  end

  it "has an id attribute" do
    expect(described_class.new(id: "sr-1").id).to eq("sr-1")
  end

  it "serializes with oa:SpecificResource type" do
    expect(described_class.new(id: "sr-1").to_turtle).to include("a oa:SpecificResource")
  end

  it "maps has_source to oa:hasSource" do
    sr = described_class.new(id: "sr-1", has_source: "doc-1")
    expect(sr.to_turtle).to include("oa:hasSource")
  end

  it "maps has_selector to oa:hasSelector" do
    sr = described_class.new(id: "sr-1", has_selector: "sel-1")
    expect(sr.to_turtle).to include("oa:hasSelector")
  end

  it "maps is_successor_of to smart:isSuccessorOf" do
    sr = described_class.new(id: "sr-1", is_successor_of: "sr-0")
    expect(sr.to_turtle).to include("smart:isSuccessorOf")
  end

  it "maps value to rdf:value" do
    sr = described_class.new(id: "sr-1", value: "some text")
    expect(sr.to_turtle).to include("rdf:value")
  end

  it "maps format to dcterms:format" do
    sr = described_class.new(id: "sr-1", format: "text/html")
    expect(sr.to_turtle).to include("dcterms:format")
  end
end

RSpec.describe SduSmart::Selector do
  it "inherits from Lutaml::Model::Serializable" do
    expect(described_class).to be < Lutaml::Model::Serializable
  end

  it "does not inherit from Entity" do
    expect(described_class).not_to be < SduSmart::Entity
  end

  it "has an id attribute" do
    expect(described_class.new(id: "sel-1").id).to eq("sel-1")
  end

  it "serializes with oa:Selector type" do
    expect(described_class.new(id: "sel-1").to_turtle).to include("a oa:Selector")
  end

  it "maps value to rdf:value" do
    sel = described_class.new(id: "sel-1", value: "xpath:///p[1]")
    expect(sel.to_turtle).to include("rdf:value")
  end
end

RSpec.describe SduSmart::Derivation do
  it "inherits from Lutaml::Model::Serializable" do
    expect(described_class).to be < Lutaml::Model::Serializable
  end

  it "does not inherit from Entity" do
    expect(described_class).not_to be < SduSmart::Entity
  end

  it "has an id attribute" do
    expect(described_class.new(id: "deriv-1").id).to eq("deriv-1")
  end

  it "serializes with prov:Derivation type" do
    expect(described_class.new(id: "deriv-1").to_turtle).to include("a prov:Derivation")
  end

  it "maps entity to prov:entity" do
    deriv = described_class.new(id: "deriv-1", entity: "iso-80000-3-2006")
    expect(deriv.to_turtle).to include("prov:entity")
  end

  it "maps change_note to skos:changeNote" do
    deriv = described_class.new(id: "deriv-1", change_note: "Updated definition")
    expect(deriv.to_turtle).to include("skos:changeNote")
  end
end
