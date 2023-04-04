# frozen_string_literal: true

describe Goldendocx::HasChildren do
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
