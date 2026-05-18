# frozen_string_literal: true

RSpec.describe "Turtle round-trip" do
  it "round-trips PublicationDocument" do
    doc = SduSmart::PublicationDocument.new(
      id: "iso-80000-3",
      publication_type: "internationalStandard",
      issued: "2019",
    )
    restored = SduSmart::PublicationDocument.from_turtle(doc.to_turtle)
    expect(restored.publication_type).to eq("internationalStandard")
    expect(restored.issued).to eq("2019")
  end

  it "round-trips Provision" do
    prov = SduSmart::Provision.new(
      id: "prov-1",
      bindingness_type: "normative",
      provision_type: "governingProvision",
    )
    restored = SduSmart::Provision.from_turtle(prov.to_turtle)
    expect(restored.bindingness_type).to eq("normative")
    expect(restored.provision_type).to eq("governingProvision")
  end

  it "round-trips Clause" do
    clause = SduSmart::Clause.new(
      id: "clause-4",
      title: "Quantities",
      section_number: "4",
      bindingness_type: "normative",
    )
    restored = SduSmart::Clause.from_turtle(clause.to_turtle)
    expect(restored.title).to eq("Quantities")
    expect(restored.section_number).to eq("4")
    expect(restored.bindingness_type).to eq("normative")
  end

  it "round-trips Term" do
    term = SduSmart::Term.new(
      id: "term-length",
      pronunciation: "lengθ",
      term_form_type: "fullForm",
      part_of_speech_type: "noun",
      used_in_country: ["GB", "US"],
      literal_form: "length",
    )
    restored = SduSmart::Term.from_turtle(term.to_turtle)
    expect(restored.pronunciation).to eq("lengθ")
    expect(restored.term_form_type).to eq("fullForm")
    expect(restored.part_of_speech_type).to eq("noun")
    expect(restored.literal_form).to eq("length")
  end

  it "round-trips ProvisionSupplement" do
    sup = SduSmart::ProvisionSupplement.new(
      id: "note-3-1",
      supplement_type: "note",
      bindingness_type: "informative",
    )
    restored = SduSmart::ProvisionSupplement.from_turtle(sup.to_turtle)
    expect(restored.supplement_type).to eq("note")
    expect(restored.bindingness_type).to eq("informative")
  end

  it "round-trips Taxonomy concept" do
    bt = SduSmart::Taxonomy::BindingnessType.fetch("normative")
    restored = SduSmart::Taxonomy::BindingnessType.from_turtle(bt.to_turtle)
    expect(restored.label).to eq("normative")
  end

  it "round-trips Annotation" do
    ann = SduSmart::Annotation.new(
      id: "ann-1",
      has_target: "sr-1",
      has_body: "prov-1",
    )
    restored = SduSmart::Annotation.from_turtle(ann.to_turtle)
    expect(restored.has_target).to eq("sr-1")
    expect(restored.has_body).to eq("prov-1")
  end

  it "round-trips SpecificResource" do
    sr = SduSmart::SpecificResource.new(
      id: "sr-1",
      has_source: "doc-1",
      has_selector: "sel-1",
      value: "some text",
      format: "text/html",
    )
    restored = SduSmart::SpecificResource.from_turtle(sr.to_turtle)
    expect(restored.has_source).to eq("doc-1")
    expect(restored.has_selector).to eq("sel-1")
    expect(restored.value).to eq("some text")
    expect(restored.format).to eq("text/html")
  end

  it "round-trips Selector" do
    sel = SduSmart::Selector.new(id: "sel-1", value: "xpath:///p[1]")
    restored = SduSmart::Selector.from_turtle(sel.to_turtle)
    expect(restored.value).to eq("xpath:///p[1]")
  end

  it "round-trips Derivation" do
    deriv = SduSmart::Derivation.new(
      id: "deriv-1",
      entity: "iso-80000-3-2006",
      change_note: "Updated definition",
    )
    restored = SduSmart::Derivation.from_turtle(deriv.to_turtle)
    expect(restored.entity).to eq("iso-80000-3-2006")
    expect(restored.change_note).to eq("Updated definition")
  end

  it "round-trips TermEntry with new properties" do
    entry = SduSmart::TermEntry.new(
      id: "te1",
      definition: "length of a line",
      identifier: "3-1",
      scope_note: "Applies to vectors",
    )
    restored = SduSmart::TermEntry.from_turtle(entry.to_turtle)
    expect(restored.definition).to eq("length of a line")
    expect(restored.identifier).to eq("3-1")
    expect(restored.scope_note).to eq("Applies to vectors")
  end

  it "round-trips Provision with distribution" do
    prov = SduSmart::Provision.new(
      id: "prov-1",
      bindingness_type: "normative",
      distribution: ["dist-1"],
    )
    restored = SduSmart::Provision.from_turtle(prov.to_turtle)
    expect(restored.bindingness_type).to eq("normative")
    expect(restored.distribution).to include("dist-1")
  end
end
