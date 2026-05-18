# frozen_string_literal: true

RSpec.describe "Class hierarchy" do
  it "Entity inherits from Lutaml::Model::Serializable" do
    expect(SduSmart::Entity < Lutaml::Model::Serializable).to be true
  end

  # Direct subclasses of Entity
  { Provision: :Entity,
    ProvisionSet: :Entity,
    ProvisionSupplement: :Entity,
    TermEntry: :Entity,
    Term: :Entity,
    PublicationDocument: :Entity,
    Agent: :Entity,
    Activity: :Entity }.each do |klass, parent|
    it "#{klass} inherits from #{parent}" do
      expect(SduSmart.const_get(klass) < SduSmart.const_get(parent)).to be true
    end
  end

  # Indirect subclasses
  it "Clause inherits from ProvisionSet" do
    expect(SduSmart::Clause < SduSmart::ProvisionSet).to be true
  end

  it "Organization inherits from Agent" do
    expect(SduSmart::Organization < SduSmart::Agent).to be true
  end

  # Provision subtypes
  %i[Statement Instruction Requirement Recommendation Permission Capability Possibility ExternalConstraint].each do |name|
    it "#{name} inherits from Provision" do
      expect(SduSmart.const_get(name) < SduSmart::Provision).to be true
    end
  end

  # Non-Entity model classes (inherit from Serializable directly)
  %i[Annotation SpecificResource Selector Derivation].each do |name|
    it "#{name} inherits from Lutaml::Model::Serializable" do
      expect(SduSmart.const_get(name) < Lutaml::Model::Serializable).to be true
    end

    it "#{name} does not inherit from Entity" do
      expect(SduSmart.const_get(name) < SduSmart::Entity).to be_falsey
    end
  end
end
