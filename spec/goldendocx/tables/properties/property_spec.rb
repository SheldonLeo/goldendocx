# frozen_string_literal: true

describe Goldendocx::Tables::Properties::Property do
  let(:property) { described_class.new }

  specify 'builds default table property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:tblPr>
        <w:tblStyle/>
        <w:tblW w:w="8600" w:type="dxa"/>
      </w:tblPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end

  specify 'builds customized table property xml' do
    property.build_table_style(style_id: 'style_id')
    property.table_width.tap { |p| p.width = 5000 }

    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:tblPr>
        <w:tblStyle w:val="style_id"/>
        <w:tblW w:w="5000" w:type="dxa"/>
      </w:tblPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end
end
