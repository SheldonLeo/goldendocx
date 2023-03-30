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

  context 'with attributes' do
    it 'defines attributes for class' do
      element_class = Class.new do
        include Goldendocx::Element

        attribute :name
        attribute :color, namespace: :w
        attribute :style, alias_name: :s, default: 'STYLE'
      end

      expect(element_class.attributes.size).to eq(3)
      expect(element_class.attributes['name']).to eq({})
      expect(element_class.attributes['color']).to eq(namespace: :w)
      expect(element_class.attributes['style']).to eq(alias_name: :s, default: 'STYLE')

      element = element_class.new
      expect(element.attributes).to eq('s' => 'STYLE')
    end

    it 'defines setter and getter for instances' do
      element_class = Class.new do
        include Goldendocx::Element

        attribute :name
        attribute :gender, readonly: true
      end

      element = element_class.new
      expect(element).to be_respond_to(:name)
      expect(element).to be_respond_to(:name=)

      expect(element).to be_respond_to(:gender)
      expect(element).not_to be_respond_to(:gender=)
    end

    it 'assigns attributes' do
      element_class = Class.new do
        include Goldendocx::Element

        attribute :name
        attribute :gender
      end

      element = element_class.new
      element.assign_attributes(name: 'Harry', gender: :boy)
      expect(element.attributes).to eq('gender' => :boy, 'name' => 'Harry')
    end
  end

  context 'with children' do
    let!(:child_class) do
      Class.new do
        attr_accessor :name
        attr_reader :gender
      end
    end

    before { stub_const('ChildClass', child_class) }

    context 'when has one child' do
      let(:element_class) do
        Class.new do
          include Goldendocx::Element

          embeds_one :child, class_name: 'ChildClass', auto_build: true
        end
      end
      let(:element) { element_class.new }

      it 'defines getter and builder' do
        expect(element).to be_respond_to(:child)
        expect(element.child).to be_a(ChildClass)

        expect(element).to be_respond_to(:build_child)
      end

      it 'builds a child' do
        child = element.build_child name: 'Harry', gender: :boy
        expect(child).to be_a(ChildClass)
        expect(child.name).to eq('Harry')
        expect(child.gender).not_to eq(:boy)
      end
    end

    context 'when has many children' do
      let(:element_class) do
        Class.new do
          include Goldendocx::Element

          embeds_many :children, class_name: 'ChildClass'
        end
      end
      let(:element) { element_class.new }

      it 'defines getter and builder' do
        expect(element).to be_respond_to(:children)
        expect(element.children).to eq([])

        expect(element).to be_respond_to(:build_child)
      end

      it 'builds a child' do
        child = element.build_child name: 'Harry', gender: :boy
        expect(child).to be_a(ChildClass)
        expect(child.name).to eq('Harry')
        expect(child.gender).not_to eq(:boy)
        expect(element.children.first).to eq(child)
      end
    end
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

        elements = element_class.read_from(node)
        expect(elements.size).to eq(1)

        element = elements.first
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

        fathers = father_class.read_from(node)
        expect(fathers.size).to eq(1)

        father = fathers.first
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
