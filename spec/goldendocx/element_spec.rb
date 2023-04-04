# frozen_string_literal: true

describe Goldendocx::Element do
  specify 'assigns namespace' do
    element_class = Class.new do
      include Goldendocx::Element

      namespace :ele
    end

    expect(element_class.namespace).to eq(:ele)
  end

  specify 'assigns tag' do
    element_class = Class.new do
      include Goldendocx::Element

      tag :element
    end

    expect(element_class.tag).to eq(:element)
  end

  describe '#to_xml' do
    let!(:element_class) do
      Class.new do
        include Goldendocx::Element

        namespace :hello
        tag :world

        attribute :spring, namespace: :java, alias_name: :version, default: :jdk11
        attribute :rails, namespace: :ruby
      end
    end

    it 'returns element xml' do
      element = element_class.new
      element.assign_attributes(rails: '7.0')

      expect(element.to_xml).to eq('<hello:world java:version="jdk11" ruby:rails="7.0"/>')
    end
  end

  describe '.read_from' do
    context 'with attributes' do
      let!(:element_class) do
        Class.new do
          include Goldendocx::Element

          namespace :hello
          tag :world

          attribute :spring, namespace: :java, alias_name: :version, default: :jdk11
          attribute :rails, namespace: :ruby
        end
      end

      it 'reads element attributes from xml' do
        xml = <<~XML
          <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
          <hello:world java:version="jdk11" ruby:rails="7.0"/>
        XML
        node = Goldendocx.xml_serializer.parse(xml)

        element = element_class.read_from(node)
        expect(element.spring).to eq('jdk11')
        expect(element.rails).to eq('7.0')
      end
    end

    context 'with children' do
      let!(:son_class) do
        Class.new do
          include Goldendocx::Element

          tag :Son
          namespace :S
          attribute :name
          embeds_one :status, class_name: 'String'
        end
      end

      let!(:daughter_class) do
        Class.new do
          include Goldendocx::Element

          tag :Daughter
          namespace :D
          attribute :name, namespace: :lovely
          embeds_one :status, class_name: 'String'
        end
      end

      let!(:father_class) do
        Class.new do
          include Goldendocx::Element

          tag :Father
          namespace :F
          embeds_one :son, class_name: 'SonClass'
          embeds_many :daughters, class_name: 'DaughterClass'
        end
      end

      before do
        stub_const('SonClass', son_class)
        stub_const('DaughterClass', daughter_class)
      end

      it 'reads element children from xml' do
        xml = <<~XML
          <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
          <F:Father>
            <S:Son name="Don">Good</S:Son>
            <D:Daughter lovely:name="Lily">Better</D:Daughter>
            <D:Daughter lovely:name="Pinkie">Best</D:Daughter>
          </F:Father>
        XML
        node = Goldendocx.xml_serializer.parse(xml)

        father = father_class.read_from(node)
        expect(father.son).to be_present
        expect(father.son.name).to eq('Don')
        expect(father.son.status).to eq('Good')

        expect(father.daughters.size).to eq(2)
        expect(father.daughters.map(&:name)).to eq(%w[Lily Pinkie])
        expect(father.daughters.map(&:status)).to eq(%w[Better Best])
      end
    end
  end
end
