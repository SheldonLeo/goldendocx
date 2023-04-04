# frozen_string_literal: true

describe Goldendocx::Documents::Document do
  let(:document) { described_class.new }
  let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }
  let(:document_xml) { Goldendocx.xml_serializer.parse(docx_file.read(described_class::XML_PATH)) }

  describe '#to_document_xml' do
    let(:xml) { document.to_document_xml }

    it 'builds default document.xml' do
      expected_xml = File.read('spec/fixtures/default_document.xml').gsub(/\s+/, '')
      expect(xml.gsub(/\s+/, '')).to eq(expected_xml)
    end
  end

  it 'reads document.xml from docx file' do
    document = described_class.read_from(document_xml)

    body = document.body
    expect(body.components.size).to eq(1)

    section_property = body.section_property
    expect(section_property.size.height).to eq('16838')
  end
end
