# frozen_string_literal: true

describe Goldendocx::HasAssociations do
  let(:klass) do
    Class.new do
      include Goldendocx::HasAssociations

      relationships_at 'relationship.rels'
      associate :relations, class_name: 'AssociationClass'
      associate :partners, class_name: 'PartnerClass'
    end
  end
  let(:instance) { klass.new }

  before do
    stub_const('AssociationClass', Class.new)
    stub_const('PartnerClass', Class.new)
  end

  specify 'records associations' do
    expect(instance.relationships_xml_path).to eq('relationship.rels')
    expect(instance.relations).to be_an AssociationClass
    expect(instance.partners).to be_a PartnerClass
  end

  specify 'not conflicts when another class with same association class' do
    another_class = Class.new do
      include Goldendocx::HasAssociations

      relationships_at '_rels/relationship.rels'
      associate :news, class_name: 'AssociationClass'
    end
    another_instance = another_class.new

    expect(instance.relationships_xml_path).to eq('relationship.rels')

    expect(another_instance.news).to be_an AssociationClass
    expect(another_instance.relationships_xml_path).to eq('_rels/relationship.rels')
  end
end
