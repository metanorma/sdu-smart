# frozen_string_literal: true

RSpec.describe SduSmart::Taxonomy::Concept do
  it "inherits from Lutaml::Model::Serializable" do
    expect(described_class).to be < Lutaml::Model::Serializable
  end

  it "is not an Entity" do
    expect(described_class).not_to be < SduSmart::Entity
  end

  it "has a label attribute" do
    instance = described_class.new(label: "test")
    expect(instance.label).to eq("test")
  end
end

RSpec.describe SduSmart::Taxonomy::BindingnessType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "BindingnessType",
    values: %w[normative informative],
    subject_path: "bindingness-type"
end

RSpec.describe SduSmart::Taxonomy::ProvisionType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "ProvisionType",
    values: %w[governingProvision assertionalProvision],
    subject_path: "provision-type"
end

RSpec.describe SduSmart::Taxonomy::PublicationComponentType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "PublicationComponentType",
    values: %w[code figure mathematicalFormula table textual],
    subject_path: "publication-component-type"
end

RSpec.describe SduSmart::Taxonomy::PublicationDocumentType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "PublicationDocumentType",
    values: %w[
      guide publiclyAvailableSpecification technicalReport
      technicalSpecification normativeDocument standard
      internationalStandard
    ],
    subject_path: "publication-type"
end

RSpec.describe SduSmart::Taxonomy::ProvisionSupplementType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "ProvisionSupplementType",
    values: %w[example footnote note],
    subject_path: "provision-supplement-type"
end

RSpec.describe SduSmart::Taxonomy::PartOfSpeechType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "PartOfSpeechType",
    values: %w[adjective adverb noun verb],
    subject_path: "part-of-speech-type"
end

RSpec.describe SduSmart::Taxonomy::TermFormType do
  it_behaves_like "a taxonomy concept",
    rdf_type: "TermFormType",
    values: %w[abbreviation acronym equation formula fullForm symbol variant],
    subject_path: "term-form-type"
end
