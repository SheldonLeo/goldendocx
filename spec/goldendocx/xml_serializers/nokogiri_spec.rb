# frozen_string_literal: true

require 'goldendocx/xml_serializers/nokogiri'

describe Goldendocx::XmlSerializers::Nokogiri, :xml_serializer do
  it_behaves_like 'with xml serializer'

  describe '.parse' do
    specify 'process with namespaces if parse a fragment' do
      fragment = <<~XML.gsub(/(^\s+)|\n/, '')
         <w:rPrDefault>
          <w:rPr>
            <w:lang w:bidi="ar-SA" w:eastAsia="zh-CN" w:val="en-US"/>
            <w:rFonts w:ascii="Times New Roman" w:eastAsia="宋体" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>
          </w:rPr>
        </w:rPrDefault>
      XML

      expect(described_class.parse(fragment, %w[w:rPrDefault w:rPr]).size).to eq(1)
      expect(described_class.parse(fragment, %w[w:rPrDefault w:rPr w:lang]).size).to eq(1)
    end

    specify 'process with none namespaces if parse a fragment' do
      fragment = <<~XML.gsub(/(^\s+)|\n/, '')
        <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
          <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
          <Default Extension="xml" ContentType="application/xml"/>
          <Default Extension="png" ContentType="image/png"/>
        </Types>
      XML

      expect(described_class.parse(fragment, %w[Types]).size).to eq(1)
      expect(described_class.parse(fragment, %w[Types Default]).size).to eq(3)
    end
  end
end
