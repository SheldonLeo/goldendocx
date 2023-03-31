# frozen_string_literal: true

describe Goldendocx::Documents::Properties::RunDefaultStyleProperty do
  let(:property) { described_class.new }

  specify 'builds default run default style property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
       <w:rPrDefault>
        <w:rPr>
          <w:lang w:bidi="ar-SA" w:eastAsia="zh-CN" w:val="en-US"/>
          <w:rFonts w:ascii="Times New Roman" w:eastAsia="宋体" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>
        </w:rPr>
      </w:rPrDefault>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end
end
