# frozen_string_literal: true

RSpec.describe SduSmart do
  # ── Class hierarchy ──────────────────────────────────────────────

  describe "class hierarchy" do
    it "Entity inherits from Lutaml::Model::Serializable" do
      expect(SduSmart::Entity < Lutaml::Model::Serializable).to be true
    end

    it "Provision inherits from Entity" do
      expect(SduSmart::Provision < SduSmart::Entity).to be true
    end

    it "ProvisionSet inherits from Entity" do
      expect(SduSmart::ProvisionSet < SduSmart::Entity).to be true
    end

    it "Clause inherits from ProvisionSet" do
      expect(SduSmart::Clause < SduSmart::ProvisionSet).to be true
    end

    it "ProvisionSupplement inherits from Entity" do
      expect(SduSmart::ProvisionSupplement < SduSmart::Entity).to be true
    end

    it "TermEntry inherits from Entity" do
      expect(SduSmart::TermEntry < SduSmart::Entity).to be true
    end

    it "Term inherits from Entity" do
      expect(SduSmart::Term < SduSmart::Entity).to be true
    end

    it "PublicationDocument inherits from Entity" do
      expect(SduSmart::PublicationDocument < SduSmart::Entity).to be true
    end

    it "Agent inherits from Entity" do
      expect(SduSmart::Agent < SduSmart::Entity).to be true
    end

    it "Organization inherits from Agent" do
      expect(SduSmart::Organization < SduSmart::Agent).to be true
    end

    it "Activity inherits from Entity" do
      expect(SduSmart::Activity < SduSmart::Entity).to be true
    end
  end

  # ── Provision subtypes ───────────────────────────────────────────

  describe "provision subtypes" do
    before { SduSmart::Provision }

    {
      Statement: "smart:Statement",
      Instruction: "smart:Instruction",
      Recommendation: "smart:Recommendation",
      Requirement: "smart:Requirement",
      Permission: "smart:Permission",
      Capability: "smart:Capability",
      Possibility: "smart:Possibility",
      ExternalConstraint: "smart:ExternalConstraint",
    }.each do |klass, type|
      it "#{klass} inherits from Provision" do
        expect(SduSmart.const_get(klass) < SduSmart::Provision).to be true
      end

      it "#{klass} serializes to Turtle with correct rdf:type" do
        instance = SduSmart.const_get(klass).new(
          id: "test-#{klass.to_s.gsub(/(.)([A-Z])/, '\1-\2').downcase}",
        )
        turtle = instance.to_turtle
        expect(turtle).to include("a #{type}")
      end
    end
  end

  # ── Entity attributes ────────────────────────────────────────────

  describe "Entity" do
    it "has an id attribute" do
      entity = SduSmart::Entity.new(id: "test-1")
      expect(entity.id).to eq("test-1")
    end

    it "uses id in subject URI" do
      entity = SduSmart::Entity.new(id: "my-entity")
      turtle = entity.to_turtle
      expect(turtle).to include("smart:my-entity")
    end

    it "serializes with smart:Entity type" do
      entity = SduSmart::Entity.new(id: "test-1")
      expect(entity.to_turtle).to include("a smart:Entity")
    end

    it "does not map id to dcterms:title" do
      entity = SduSmart::Entity.new(id: "test-1")
      expect(entity.to_turtle).not_to include("dcterms:title")
    end
  end

  # ── Individual entity classes ────────────────────────────────────

  describe "PublicationDocument" do
    it "generates correct Turtle" do
      doc = SduSmart::PublicationDocument.new(
        id: "iso-80000-1",
        publication_type: "internationalStandard",
        issued: "2022",
      )
      turtle = doc.to_turtle
      expect(turtle).to include("a smart:PublicationDocument")
      expect(turtle).to include("smart:hasPublicationType")
      expect(turtle).to include("dcterms:issued")
    end

    it "includes has_version predicate" do
      doc = SduSmart::PublicationDocument.new(
        id: "iso-80000-1",
        has_version: ["v1", "v2"],
      )
      turtle = doc.to_turtle
      expect(turtle).to include("dcterms:hasVersion")
    end

    it "includes replaces predicate" do
      doc = SduSmart::PublicationDocument.new(
        id: "iso-80000-1",
        replaces: "iso-80000-1-2019",
      )
      turtle = doc.to_turtle
      expect(turtle).to include("dcterms:replaces")
    end
  end

  describe "Provision" do
    it "generates correct Turtle" do
      prov = SduSmart::Provision.new(
        id: "prov-1",
        bindingness_type: "normative",
        provision_type: "governingProvision",
        publication_component_type: "textual",
        is_part_of: "clause-4",
      )
      turtle = prov.to_turtle
      expect(turtle).to include("a smart:Provision")
      expect(turtle).to include("smart:hasBindingnessType")
      expect(turtle).to include("smart:hasProvisionType")
      expect(turtle).to include("smart:hasPublicationComponentType")
      expect(turtle).to include("dcterms:isPartOf")
    end

    it "includes has_supplement predicate" do
      prov = SduSmart::Provision.new(
        id: "prov-1",
        has_supplement: ["note-1", "example-1"],
      )
      turtle = prov.to_turtle
      expect(turtle).to include("smart:hasSupplement")
    end
  end

  describe "Clause" do
    it "generates correct Turtle" do
      clause = SduSmart::Clause.new(
        id: "clause-4",
        title: "Quantities",
        section_number: "4",
        bindingness_type: "normative",
      )
      turtle = clause.to_turtle
      expect(turtle).to include("a smart:Clause")
      expect(turtle).to include("smart:hasBindingnessType")
      expect(turtle).to include("smart:hasSectionNumber")
      expect(turtle).to include("dcterms:title")
      expect(turtle).to include("smart:isSuccessorOf") if clause.is_successor_of
    end

    it "maps title attribute to dcterms:title" do
      clause = SduSmart::Clause.new(
        id: "clause-4",
        title: "Quantities",
      )
      turtle = clause.to_turtle
      expect(turtle).to include(%("Quantities"))
    end

    it "includes isPartOf predicate" do
      clause = SduSmart::Clause.new(
        id: "clause-4-1",
        is_part_of: "clause-4",
      )
      turtle = clause.to_turtle
      expect(turtle).to include("dcterms:isPartOf")
    end
  end

  describe "ProvisionSupplement" do
    it "generates correct Turtle" do
      sup = SduSmart::ProvisionSupplement.new(
        id: "note-3-1",
        supplement_type: "note",
        bindingness_type: "normative",
        publication_component_type: "textual",
      )
      turtle = sup.to_turtle
      expect(turtle).to include("a smart:ProvisionSupplement")
      expect(turtle).to include("smart:hasSupplementType")
      expect(turtle).to include("smart:hasBindingnessType")
      expect(turtle).to include("smart:hasPublicationComponentType")
    end
  end

  describe "TermEntry" do
    it "generates correct Turtle" do
      entry = SduSmart::TermEntry.new(
        id: "term-entry-3-1-1",
        bindingness_type: "normative",
      )
      turtle = entry.to_turtle
      expect(turtle).to include("a smart:TermEntry")
      expect(turtle).to include("smart:hasBindingnessType")
    end

    it "includes isPartOf predicate" do
      entry = SduSmart::TermEntry.new(
        id: "term-entry-3-1-1",
        is_part_of: "clause-3-1",
      )
      turtle = entry.to_turtle
      expect(turtle).to include("dcterms:isPartOf")
    end
  end

  describe "Term" do
    it "generates correct Turtle" do
      term = SduSmart::Term.new(
        id: "term-length",
        pronunciation: "lengθ",
        term_form_type: "fullForm",
        part_of_speech_type: "noun",
        used_in_country: "GB",
      )
      turtle = term.to_turtle
      expect(turtle).to include("a smart:Term")
      expect(turtle).to include("smart:pronunciation")
      expect(turtle).to include("smart:hasTermFormType")
      expect(turtle).to include("smart:hasPartOfSpeechType")
      expect(turtle).to include("smart:usedInCountry")
    end
  end

  describe "Agent" do
    it "generates correct Turtle" do
      agent = SduSmart::Agent.new(id: "agent-iso")
      turtle = agent.to_turtle
      expect(turtle).to include("a smart:Agent")
    end
  end

  describe "Organization" do
    it "generates correct Turtle" do
      org = SduSmart::Organization.new(id: "org-iso")
      turtle = org.to_turtle
      expect(turtle).to include("a smart:Organization")
    end
  end

  describe "Activity" do
    it "generates correct Turtle" do
      activity = SduSmart::Activity.new(id: "activity-1")
      turtle = activity.to_turtle
      expect(turtle).to include("a smart:Activity")
    end
  end

  describe "ProvisionSet" do
    it "generates correct Turtle" do
      ps = SduSmart::ProvisionSet.new(id: "ps-1")
      turtle = ps.to_turtle
      expect(turtle).to include("a smart:ProvisionSet")
    end
  end

  # ── Taxonomy classes ─────────────────────────────────────────────

  describe "taxonomy classes" do
    describe SduSmart::Taxonomy::BindingnessType do
      subject { described_class }

      it { is_expected.to be < Lutaml::Model::Serializable }
      it { is_expected.not_to be < SduSmart::Entity }

      it "has correct VALUES" do
        expect(subject::VALUES).to contain_exactly("normative", "informative")
      end

      it "generates correct Turtle" do
        bt = subject.new(label: "normative")
        turtle = bt.to_turtle
        expect(turtle).to include("a smart:BindingnessType")
        expect(turtle).to include("skos:prefLabel")
      end

      it "uses correct subject URI" do
        bt = subject.new(label: "normative")
        expect(bt.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/bindingness-type/normative>",
        )
      end
    end

    describe SduSmart::Taxonomy::ProvisionType do
      subject { described_class }

      it "has correct VALUES" do
        expect(subject::VALUES).to contain_exactly("governingProvision", "assertionalProvision")
      end

      it "generates correct Turtle" do
        pt = subject.new(label: "governingProvision")
        turtle = pt.to_turtle
        expect(turtle).to include("a smart:ProvisionType")
        expect(turtle).to include("skos:prefLabel")
      end

      it "uses correct subject URI" do
        pt = subject.new(label: "governingProvision")
        expect(pt.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/provision-type/governingProvision>",
        )
      end
    end

    describe SduSmart::Taxonomy::PublicationComponentType do
      subject { described_class }

      it "has correct VALUES" do
        expect(subject::VALUES).to contain_exactly(
          "code", "figure", "mathematicalFormula", "table", "textual",
        )
      end

      it "uses correct subject URI" do
        pct = subject.new(label: "mathematicalFormula")
        expect(pct.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/publication-component-type/mathematicalFormula>",
        )
      end
    end

    describe SduSmart::Taxonomy::PublicationDocumentType do
      subject { described_class }

      it "has correct VALUES matching ontology taxonomy" do
        expect(subject::VALUES).to contain_exactly(
          "guide",
          "publiclyAvailableSpecification",
          "technicalReport",
          "technicalSpecification",
          "normativeDocument",
          "standard",
          "internationalStandard",
        )
      end

      it "uses correct subject URI" do
        pdt = subject.new(label: "internationalStandard")
        expect(pdt.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/publication-type/internationalStandard>",
        )
      end
    end

    describe SduSmart::Taxonomy::ProvisionSupplementType do
      subject { described_class }

      it "has correct VALUES" do
        expect(subject::VALUES).to contain_exactly("example", "footnote", "note")
      end

      it "uses correct subject URI" do
        pst = subject.new(label: "footnote")
        expect(pst.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/provision-supplement-type/footnote>",
        )
      end
    end

    describe SduSmart::Taxonomy::PartOfSpeechType do
      subject { described_class }

      it "has correct VALUES" do
        expect(subject::VALUES).to contain_exactly("adjective", "adverb", "noun", "verb")
      end

      it "uses correct subject URI" do
        pos = subject.new(label: "noun")
        expect(pos.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/part-of-speech-type/noun>",
        )
      end
    end

    describe SduSmart::Taxonomy::TermFormType do
      subject { described_class }

      it "has correct VALUES" do
        expect(subject::VALUES).to contain_exactly(
          "abbreviation", "acronym", "equation", "formula",
          "fullForm", "symbol", "variant",
        )
      end

      it "uses correct subject URI" do
        tft = subject.new(label: "fullForm")
        expect(tft.to_turtle).to include(
          "<https://w3id.org/standards/smart/taxonomies/term-form-type/fullForm>",
        )
      end
    end
  end

  # ── RDF namespaces ───────────────────────────────────────────────

  describe "RDF namespaces" do
    describe SduSmart::Rdf::Namespaces::SmartNamespace do
      it "has prefix 'smart'" do
        expect(described_class.prefix).to eq("smart")
      end

      it "has correct URI" do
        expect(described_class.uri).to eq(
          "https://w3id.org/standards/smart/ontologies/core/",
        )
      end
    end

    describe SduSmart::Rdf::Namespaces::IsoIec80000Namespace do
      it "has prefix 'isoiec80000'" do
        expect(described_class.prefix).to eq("isoiec80000")
      end

      it "has correct URI" do
        expect(described_class.uri).to eq(
          "https://w3id.org/standards/isoiec80000/ontologies/core/",
        )
      end
    end

    describe SduSmart::Rdf::Namespaces::OaNamespace do
      it "has prefix 'oa'" do
        expect(described_class.prefix).to eq("oa")
      end

      it "has correct URI" do
        expect(described_class.uri).to eq("http://www.w3.org/ns/oa#")
      end
    end
  end

  # ── Subject URI pattern ─────────────────────────────────────────

  describe "subject URI pattern" do
    it "uses smart: namespace for entity subjects" do
      entity = SduSmart::Entity.new(id: "test")
      turtle = entity.to_turtle
      expect(turtle).to include("smart:test")
    end
  end

  # ── Turtle round-trip ────────────────────────────────────────────

  describe "Turtle round-trip" do
    it "round-trips PublicationDocument" do
      doc = SduSmart::PublicationDocument.new(
        id: "iso-80000-3",
        publication_type: "internationalStandard",
        issued: "2019",
      )
      turtle = doc.to_turtle
      restored = SduSmart::PublicationDocument.from_turtle(turtle)
      expect(restored.publication_type).to eq("internationalStandard")
      expect(restored.issued).to eq("2019")
    end

    it "round-trips Provision" do
      prov = SduSmart::Provision.new(
        id: "prov-1",
        bindingness_type: "normative",
        provision_type: "governingProvision",
      )
      turtle = prov.to_turtle
      restored = SduSmart::Provision.from_turtle(turtle)
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
      turtle = clause.to_turtle
      restored = SduSmart::Clause.from_turtle(turtle)
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
      )
      turtle = term.to_turtle
      restored = SduSmart::Term.from_turtle(turtle)
      expect(restored.pronunciation).to eq("lengθ")
      expect(restored.term_form_type).to eq("fullForm")
      expect(restored.part_of_speech_type).to eq("noun")
    end

    it "round-trips ProvisionSupplement" do
      sup = SduSmart::ProvisionSupplement.new(
        id: "note-3-1",
        supplement_type: "note",
        bindingness_type: "informative",
      )
      turtle = sup.to_turtle
      restored = SduSmart::ProvisionSupplement.from_turtle(turtle)
      expect(restored.supplement_type).to eq("note")
      expect(restored.bindingness_type).to eq("informative")
    end

    it "serializes provision subtypes with correct rdf:type" do
      stmt = SduSmart::Statement.new(id: "stmt-1")
      turtle = stmt.to_turtle
      expect(turtle).to include("a smart:Statement")
    end
  end
end
