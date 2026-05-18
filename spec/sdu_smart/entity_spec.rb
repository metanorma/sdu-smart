# frozen_string_literal: true

RSpec.describe SduSmart::Entity do
  it "inherits from Lutaml::Model::Serializable" do
    expect(described_class).to be < Lutaml::Model::Serializable
  end

  it "has an id attribute" do
    expect(described_class.new(id: "test").id).to eq("test")
  end

  it "serializes with smart:Entity type" do
    expect(described_class.new(id: "test").to_turtle).to include("a smart:Entity")
  end

  it "does not map id to dcterms:title" do
    entity = described_class.new(id: "test-1")
    expect(entity.to_turtle).not_to include("dcterms:title")
  end
end

RSpec.describe SduSmart::Provision do
  it_behaves_like "an entity subclass", rdf_type: "Provision"

  it "maps bindingness_type to smart:hasBindingnessType" do
    prov = described_class.new(id: "p1", bindingness_type: "normative")
    expect(prov.to_turtle).to include("smart:hasBindingnessType")
  end

  it "maps provision_type to smart:hasProvisionType" do
    prov = described_class.new(id: "p1", provision_type: "governingProvision")
    expect(prov.to_turtle).to include("smart:hasProvisionType")
  end

  it "maps publication_component_type to smart:hasPublicationComponentType" do
    prov = described_class.new(id: "p1", publication_component_type: "textual")
    expect(prov.to_turtle).to include("smart:hasPublicationComponentType")
  end

  it "maps is_part_of to dcterms:isPartOf" do
    prov = described_class.new(id: "p1", is_part_of: "clause-4")
    expect(prov.to_turtle).to include("dcterms:isPartOf")
  end

  it "maps has_supplement to smart:hasSupplement" do
    prov = described_class.new(id: "p1", has_supplement: ["note-1"])
    expect(prov.to_turtle).to include("smart:hasSupplement")
  end

  it "maps distribution to dcat:distribution" do
    prov = described_class.new(id: "p1", distribution: ["dist-1"])
    expect(prov.to_turtle).to include("dcat:distribution")
  end
end

RSpec.describe SduSmart::Clause do
  it_behaves_like "an entity subclass", rdf_type: "Clause"

  it "maps title to dcterms:title" do
    clause = described_class.new(id: "c1", title: "Quantities")
    expect(clause.to_turtle).to include("dcterms:title")
  end

  it "maps section_number to smart:hasSectionNumber" do
    clause = described_class.new(id: "c1", section_number: "4")
    expect(clause.to_turtle).to include("smart:hasSectionNumber")
  end

  it "maps bindingness_type to smart:hasBindingnessType" do
    clause = described_class.new(id: "c1", bindingness_type: "normative")
    expect(clause.to_turtle).to include("smart:hasBindingnessType")
  end

  it "maps is_part_of to dcterms:isPartOf" do
    clause = described_class.new(id: "c1", is_part_of: "doc-1")
    expect(clause.to_turtle).to include("dcterms:isPartOf")
  end

  it "maps is_successor_of to smart:isSuccessorOf" do
    clause = described_class.new(id: "c1", is_successor_of: "clause-3")
    expect(clause.to_turtle).to include("smart:isSuccessorOf")
  end
end

RSpec.describe SduSmart::ProvisionSupplement do
  it_behaves_like "an entity subclass", rdf_type: "ProvisionSupplement"

  it "maps supplement_type to smart:hasSupplementType" do
    sup = described_class.new(id: "s1", supplement_type: "note")
    expect(sup.to_turtle).to include("smart:hasSupplementType")
  end

  it "maps bindingness_type to smart:hasBindingnessType" do
    sup = described_class.new(id: "s1", bindingness_type: "informative")
    expect(sup.to_turtle).to include("smart:hasBindingnessType")
  end

  it "maps publication_component_type to smart:hasPublicationComponentType" do
    sup = described_class.new(id: "s1", publication_component_type: "textual")
    expect(sup.to_turtle).to include("smart:hasPublicationComponentType")
  end
end

RSpec.describe SduSmart::TermEntry do
  it_behaves_like "an entity subclass", rdf_type: "TermEntry"

  it "maps bindingness_type to smart:hasBindingnessType" do
    entry = described_class.new(id: "te1", bindingness_type: "normative")
    expect(entry.to_turtle).to include("smart:hasBindingnessType")
  end

  it "maps is_part_of to dcterms:isPartOf" do
    entry = described_class.new(id: "te1", is_part_of: "clause-3-1")
    expect(entry.to_turtle).to include("dcterms:isPartOf")
  end

  it "maps definition to skos:definition" do
    entry = described_class.new(id: "te1", definition: "length of a line")
    expect(entry.to_turtle).to include("skos:definition")
  end

  it "maps identifier to dcterms:identifier" do
    entry = described_class.new(id: "te1", identifier: "3-1")
    expect(entry.to_turtle).to include("dcterms:identifier")
  end

  it "maps scope_note to skos:scopeNote" do
    entry = described_class.new(id: "te1", scope_note: "Applies to vector quantities")
    expect(entry.to_turtle).to include("skos:scopeNote")
  end

  it "maps deprecated_label to smart:deprecatedLabel" do
    entry = described_class.new(id: "te1", deprecated_label: ["old-term"])
    expect(entry.to_turtle).to include("smart:deprecatedLabel")
  end

  it "maps pref_label to skosxl:prefLabel" do
    entry = described_class.new(id: "te1", pref_label: ["term-length"])
    expect(entry.to_turtle).to include("skosxl:prefLabel")
  end

  it "maps alt_label to skosxl:altLabel" do
    entry = described_class.new(id: "te1", alt_label: ["term-len"])
    expect(entry.to_turtle).to include("skosxl:altLabel")
  end

  it "maps qualified_derivation to prov:qualifiedDerivation" do
    entry = described_class.new(id: "te1", qualified_derivation: ["deriv-1"])
    expect(entry.to_turtle).to include("prov:qualifiedDerivation")
  end
end

RSpec.describe SduSmart::Term do
  it_behaves_like "an entity subclass", rdf_type: "Term"

  it "maps pronunciation to smart:pronunciation" do
    term = described_class.new(id: "t1", pronunciation: "lengθ")
    expect(term.to_turtle).to include("smart:pronunciation")
  end

  it "maps used_in_country to smart:usedInCountry" do
    term = described_class.new(id: "t1", used_in_country: ["GB", "US"])
    expect(term.to_turtle).to include("smart:usedInCountry")
  end

  it "maps part_of_speech_type to smart:hasPartOfSpeechType" do
    term = described_class.new(id: "t1", part_of_speech_type: "noun")
    expect(term.to_turtle).to include("smart:hasPartOfSpeechType")
  end

  it "maps term_form_type to smart:hasTermFormType" do
    term = described_class.new(id: "t1", term_form_type: "fullForm")
    expect(term.to_turtle).to include("smart:hasTermFormType")
  end

  it "maps literal_form to skosxl:literalForm" do
    term = described_class.new(id: "t1", literal_form: "intended use")
    expect(term.to_turtle).to include("skosxl:literalForm")
  end
end

RSpec.describe SduSmart::PublicationDocument do
  it_behaves_like "an entity subclass", rdf_type: "PublicationDocument"

  it "maps publication_type to smart:hasPublicationType" do
    doc = described_class.new(id: "d1", publication_type: "internationalStandard")
    expect(doc.to_turtle).to include("smart:hasPublicationType")
  end

  it "maps issued to dcterms:issued" do
    doc = described_class.new(id: "d1", issued: "2022")
    expect(doc.to_turtle).to include("dcterms:issued")
  end

  it "maps has_version to dcterms:hasVersion" do
    doc = described_class.new(id: "d1", has_version: ["v1"])
    expect(doc.to_turtle).to include("dcterms:hasVersion")
  end

  it "maps replaces to dcterms:replaces" do
    doc = described_class.new(id: "d1", replaces: "doc-old")
    expect(doc.to_turtle).to include("dcterms:replaces")
  end
end

RSpec.describe SduSmart::Agent do
  it_behaves_like "an entity subclass", rdf_type: "Agent"
end

RSpec.describe SduSmart::Organization do
  it_behaves_like "an entity subclass", rdf_type: "Organization"

  it "inherits from Agent" do
    expect(described_class < SduSmart::Agent).to be true
  end
end

RSpec.describe SduSmart::Activity do
  it_behaves_like "an entity subclass", rdf_type: "Activity"
end

RSpec.describe SduSmart::ProvisionSet do
  it_behaves_like "an entity subclass", rdf_type: "ProvisionSet"
end

# Provision subtypes: verify each has the correct rdf:type
{
  SduSmart::Statement => "smart:Statement",
  SduSmart::Instruction => "smart:Instruction",
  SduSmart::Requirement => "smart:Requirement",
  SduSmart::Recommendation => "smart:Recommendation",
  SduSmart::Permission => "smart:Permission",
  SduSmart::Capability => "smart:Capability",
  SduSmart::Possibility => "smart:Possibility",
  SduSmart::ExternalConstraint => "smart:ExternalConstraint",
}.each do |klass, rdf_type|
  RSpec.describe klass do
    it "serializes with rdf:type #{rdf_type}" do
      instance = klass.new(id: "test")
      expect(instance.to_turtle).to include("a #{rdf_type}")
    end
  end
end
