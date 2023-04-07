# frozen_string_literal: true

describe Goldendocx::Documents::Settings, :association do
  let(:settings) { described_class.new }

  let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }
  let(:settings_xml) { docx_file.read(described_class::XML_PATH) }

  describe '#to_document_xml' do
    let(:xml) { settings.to_document_xml }

    specify 'builds default settings.xml' do
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <w:settings xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"#{' '}
            xmlns:o="urn:schemas-microsoft-com:office:office"#{' '}
            xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"#{' '}
            xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"#{' '}
            xmlns:v="urn:schemas-microsoft-com:vml"#{' '}
            xmlns:w10="urn:schemas-microsoft-com:office:word"#{' '}
            xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"#{' '}
            xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"#{' '}
            xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"#{' '}
            xmlns:w16cid="http://schemas.microsoft.com/office/word/2016/wordml/cid"#{' '}
            xmlns:w16se="http://schemas.microsoft.com/office/word/2015/wordml/symex"#{' '}
            xmlns:sl="http://schemas.openxmlformats.org/schemaLibrary/2006/main"#{' '}
            mc:Ignorable="w14 w15 w16se w16cid"/>
      XML
      expect(xml).to eq(expected_xml)
    end
  end
end
