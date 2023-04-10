# frozen_string_literal: true

describe Goldendocx::Parts::Core do
  let(:core) { described_class.new }
  let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }
  let(:core_xml) { docx_file.read(described_class::XML_PATH) }

  before do
    Timecop.freeze(Time.local(2023, 11, 15))
  end

  after { Timecop.return }

  describe '#to_document_xml' do
    let(:xml) { core.to_document_xml }

    specify 'builds default core.xml' do
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"#{' '}
          xmlns:dc="http://purl.org/dc/elements/1.1/"#{' '}
          xmlns:dcterms="http://purl.org/dc/terms/"#{' '}
          xmlns:dcmitype="http://purl.org/dc/dcmitype/"#{' '}
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <dc:creator>Goldendocx_#{Goldendocx::VERSION}</dc:creator>
          <dcterms:created xsi:type="dcterms:W3CDTF">2023-11-15T00:00:00Z</dcterms:created>
        </cp:coreProperties>
      XML
      expect(xml).to eq(expected_xml)
    end

    specify 'resets modification information for original core.xml' do
      core = described_class.parse(core_xml)
      xml = core.to_document_xml
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"#{' '}
          xmlns:dc="http://purl.org/dc/elements/1.1/"#{' '}
          xmlns:dcterms="http://purl.org/dc/terms/"#{' '}
          xmlns:dcmitype="http://purl.org/dc/dcmitype/"#{' '}
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <dc:creator>Epicurus</dc:creator>
          <dcterms:created xsi:type="dcterms:W3CDTF">2023-02-17T07:29:00Z</dcterms:created>
          <cp:revision>2</cp:revision>
          <cp:lastModifiedBy>Goldendocx_#{Goldendocx::VERSION}</cp:lastModifiedBy>
          <dcterms:modified xsi:type="dcterms:W3CDTF">2023-11-15T00:00:00Z</dcterms:modified>
        </cp:coreProperties>
      XML
      expect(xml).to eq(expected_xml)
    end
  end
end
