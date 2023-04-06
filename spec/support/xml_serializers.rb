# frozen_string_literal: true

RSpec.shared_context 'with xml serializer' do
  let(:xml_serializer) { described_class }

  describe '.parse' do
    let!(:xml) do
      <<~XML
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
          <Default Extension="xml" ContentType="application/xml"/>
          <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
        </Types>
      XML
    end

    it 'parses xml elements at specific paths' do
      document = described_class.parse(xml)
      elements = described_class.search(document, %w[Types Default])
      expect(elements.size).to eq(1)
      expect(elements.first[:Extension]).to eq('xml')
    end
  end

  describe '.search' do
    let!(:xml) do
      <<~XML
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
          <Default Extension="xml" ContentType="application/xml"/>
          <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
        </Types>
      XML
    end
    let!(:node) { described_class.parse(xml) }

    it 'searches xml elements at specific paths' do
      elements = described_class.search(node, %w[Types Default])
      expect(elements.size).to eq(1)
      expect(elements.first[:Extension]).to eq('xml')
    end
  end

  describe '.build_xml' do
    it 'builds xml with given block' do
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <w:document>
          BODY_CONTENT
        </w:document>
      XML

      built_xml = described_class.build_xml('w:document') { |xml| xml << 'BODY_CONTENT' }
      expect(built_xml).to eq(expected_xml)
    end
  end

  describe '.build_document_xml' do
    it 'builds xml with namespaces' do
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"#{' '}
           xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"#{' '}
           mc:Ignorable="w14 w15"/>
      XML
      expect(described_class.build_document_xml('w:document', %i[w r], %i[w14 w15])).to eq(expected_xml)
    end
  end
end

RSpec.configure do |config|
  config.include_context 'with xml serializer', :xml_serializer
end
