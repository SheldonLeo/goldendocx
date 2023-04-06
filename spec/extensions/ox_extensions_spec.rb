# frozen_string_literal: true

require 'extensions/ox_extensions'

context 'with Ox Extensions' do
  context 'when Ox::Document' do
    let(:document) { Ox::Document.new }

    it 'returns first child as document root' do
      root_element = Ox::Element.new('Root')
      document << root_element
      expect(document.root).to eq(root_element)
    end
  end

  context 'when Ox::Element' do
    let(:element) { Ox::Element.new('Element') }

    it 'overrides `<<` method to transfer element implicitly' do
      expect { element << 1 }.not_to raise_error
    end

    it 'maintains unparsed children' do
      child1 = Ox::Element.new('Child1')
      child2 = Ox::Element.new('Child2')
      element << child1 << child2

      expect(element.children.size).to eq(2)
      expect(element.unparsed_children.size).to eq(2)

      element.unparsed_children.pop
      expect(element.children.size).to eq(2)
      expect(element.unparsed_children.size).to eq(1)

      element.unparsed_children.pop
      expect(element.children.size).to eq(2)
      expect(element.unparsed_children.size).to eq(0)
    end

    it 'reads attributes as hash' do
      element['java'] = 'jdk14'
      element[:ruby] = 3.1

      expect(element.attributes_hash).to eq('java' => 'jdk14', 'ruby' => '3.1')
    end
  end
end
