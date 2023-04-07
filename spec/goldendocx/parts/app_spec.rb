# frozen_string_literal: true

describe Goldendocx::Parts::App do
  let(:app) { described_class.new }
  let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }
  let(:app_xml) { docx_file.read(described_class::XML_PATH) }

  describe '#to_document_xml' do
    let(:xml) { app.to_document_xml }

    specify 'builds default app.xml' do
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties">
          <Application>Goldendocx_0.2.2</Application>
        </Properties>
      XML
      expect(xml).to eq(expected_xml)
    end

    specify 'keeps original app.xml' do
      app = described_class.parse(app_xml)
      xml = app.to_document_xml
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties">
          <Application>WPS Office_5.2.0.7734_F1E327BC-269C-435d-A152-05C5408002CA</Application>
          <Template>Normal.dotm</Template>
          <Pages>1</Pages>
          <Words>0</Words>
          <Characters>0</Characters>
          <Lines>0</Lines>
          <Paragraphs>0</Paragraphs>
          <TotalTime>0</TotalTime>
          <ScaleCrop>false</ScaleCrop>
          <LinksUpToDate>false</LinksUpToDate>
          <CharactersWithSpaces>0</CharactersWithSpaces>
          <DocSecurity>0</DocSecurity>
        </Properties>
      XML
      expect(xml).to eq(expected_xml)
    end
  end
end
