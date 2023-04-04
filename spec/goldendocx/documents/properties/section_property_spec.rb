# frozen_string_literal: true

describe Goldendocx::Documents::Properties::SectionProperty do
  let(:property) { described_class.new }

  specify 'builds default section property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:sectPr>
        <w:pgSz w:w="11906" w:h="16838"/>
        <w:pgMar w:top="1440" w:bottom="1440" w:left="1800" w:right="1800" w:header="851" w:footer="992" w:gutter="0"/>
      </w:sectPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end
end
