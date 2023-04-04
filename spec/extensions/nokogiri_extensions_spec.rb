# frozen_string_literal: true

require 'extensions/nokogiri_extensions'

context 'with Nokogiri Extensions' do
  context 'when Nokogiri::XML::Node' do
    let(:root) { Nokogiri::XML('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>') }
    let(:element) { Nokogiri::XML::Node.new('Element', root) }

    it 'overrides `<<` method to transfer element implicitly' do
      expect { element << 1 }.not_to raise_error
    end

    it 'extracts contents from children nodes' do
      element << 'Hello' << 'World'
      expect(element.extract_contents).to eq(['HelloWorld'])
    end

    it 'maintains unparsed children' do
      child1 = Nokogiri::XML::Node.new('Child1', element)
      child2 = Nokogiri::XML::Node.new('Child2', element)
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
