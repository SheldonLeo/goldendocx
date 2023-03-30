# frozen_string_literal: true

describe Goldendocx::HasAssociations do
  let(:klass) do
    Class.new do
      include Goldendocx::HasAssociations

      associate :relations, class_name: 'AssociationClass', path: 'hello/world.xml'
      associate :partners, class_name: 'PartnerClass', path: 'partners.png'
    end
  end
  let(:instance) { klass.new }

  before do
    stub_const('AssociationClass', Class.new)
    stub_const('PartnerClass', Class.new)
  end

  specify 'records associations' do
    expect(instance.relations).to be_an AssociationClass
    # expect(instance.relations.xml_path).to eq('hello/world.xml')

    expect(instance.partners).to be_a PartnerClass
    # expect(instance.partners.xml_path).to eq('partners.png')
  end

  specify 'not conflicts when another class with same association class', pending: 'xml_path may not be a good design' do
    another_class = Class.new do
      include Goldendocx::HasAssociations

      associate :news, class_name: 'AssociationClass', path: 'news.relations'
    end
    another_instance = another_class.new

    expect(instance.relations.xml_path).to eq('hello/world.xml')

    expect(another_instance.news).to be_an AssociationClass
    expect(another_instance.news.xml_path).to eq('news.relations')
  end
end
