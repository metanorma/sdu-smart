# frozen_string_literal: true

RSpec.describe SduSmart::Rdf::Namespaces::SmartNamespace do
  it "has prefix 'smart'" do
    expect(described_class.prefix).to eq("smart")
  end

  it "has correct URI" do
    expect(described_class.uri).to eq(
      "https://w3id.org/standards/smart/ontologies/core/",
    )
  end
end

RSpec.describe SduSmart::Rdf::Namespaces::IsoIec80000Namespace do
  it "has prefix 'isoiec80000'" do
    expect(described_class.prefix).to eq("isoiec80000")
  end

  it "has correct URI" do
    expect(described_class.uri).to eq(
      "https://w3id.org/standards/isoiec80000/ontologies/core/",
    )
  end
end

RSpec.describe SduSmart::Rdf::Namespaces::OaNamespace do
  it "has prefix 'oa'" do
    expect(described_class.prefix).to eq("oa")
  end

  it "has correct URI" do
    expect(described_class.uri).to eq("http://www.w3.org/ns/oa#")
  end
end

RSpec.describe SduSmart::Rdf::Namespaces::DcatNamespace do
  it "has prefix 'dcat'" do
    expect(described_class.prefix).to eq("dcat")
  end

  it "has correct URI" do
    expect(described_class.uri).to eq("http://www.w3.org/ns/dcat#")
  end
end

RSpec.describe SduSmart::Rdf::Namespaces::ProvNamespace do
  it "has prefix 'prov'" do
    expect(described_class.prefix).to eq("prov")
  end

  it "has correct URI" do
    expect(described_class.uri).to eq("http://www.w3.org/ns/prov#")
  end
end

RSpec.describe SduSmart::Rdf::Namespaces::SkosXlNamespace do
  it "has prefix 'skosxl'" do
    expect(described_class.prefix).to eq("skosxl")
  end

  it "has correct URI" do
    expect(described_class.uri).to eq("http://www.w3.org/2008/05/skos-xl#")
  end
end
