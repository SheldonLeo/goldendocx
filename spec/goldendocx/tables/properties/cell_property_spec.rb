# frozen_string_literal: true

describe Goldendocx::Tables::Properties::CellProperty do
  let(:property) { described_class.new }

  specify 'builds default cell property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:tcPr>
        <w:tcW w:type="auto"/>
        <w:vAlign w:val="center"/>
        <w:gridSpan/>
        <w:shd/>
      </w:tcPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end

  specify 'builds customized cell property xml' do
    property.build_grid_span(span: 3)

    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:tcPr>
        <w:tcW w:type="auto"/>
        <w:vAlign w:val="center"/>
        <w:gridSpan w:val="3"/>
        <w:shd/>
      </w:tcPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end
end
