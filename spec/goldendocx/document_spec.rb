# frozen_string_literal: true

describe Goldendocx::Document do
  describe 'act as element' do
    let!(:document_class) do
      Class.new do
        include Goldendocx::Document

        namespace :doc
        tag :document

        attribute :name, default: 'Leon'
        embeds_many :children, class_name: 'ChildClass'
      end
    end
    let!(:child_class) { Class.new { attr_accessor(:name) } }

    let(:document) { document_class.new }

    before { stub_const('ChildClass', child_class) }

    specify 'acts same as element' do
      expect(document_class.namespace).to eq(:doc)
      expect(document_class.tag).to eq(:document)
      expect(document_class.attributes).to eq('name' => { default: 'Leon' })

      document.build_child(name: 'Kid')
      expect(document.attributes).to eq('name' => 'Leon')
      expect(document.children.first).to be_a(ChildClass)
    end
  end

  it 'assigns namespaces' do
    document_class = Class.new do
      include Goldendocx::Document

      concern_namespaces :one, :two
      ignore_namespaces :three, :four
    end

    expect(document_class.concerned_namespaces).to eq(%i[one two])
    expect(document_class.ignorable_namespaces).to eq(%i[three four])
  end

  it 'builds complete document xml' do
    document_class = Class.new do
      include Goldendocx::Document

      namespace :doc
      tag :Document
      concern_namespaces :w, :r, :w14
      ignore_namespaces :w14
    end

    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
      <doc:Document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"#{' '}
            xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"#{' '}
            xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"#{' '}
           mc:Ignorable="w14"/>
    XML

    expect(document_class.new.to_document_xml).to eq(expected_xml)
  end
end
