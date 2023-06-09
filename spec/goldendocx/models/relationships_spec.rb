# frozen_string_literal: true

describe Goldendocx::Models::Relationships do
  describe '.read_from' do
    let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }
    let(:relationships_xml) { docx_file.read('word/_rels/document.xml.rels') }

    it 'reads relationships from docx file' do
      relationships = described_class.parse(relationships_xml)
      expect(relationships.relationships.size).to eq(4)
    end
  end
end
