# frozen_string_literal: true

describe Goldendocx::Charts::Properties::LineChartProperty do
  let(:property) { described_class.new }

  specify 'builds default line chart property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <c:lineChart>
        <c:grouping val="standard"/>
        <c:axId val="9374902"/>
        <c:axId val="2094739"/>
      </c:lineChart>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end

  specify 'builds line chart property xml with axes' do
    property.build_axis(axis_id: 'cat-1')
    property.build_axis(axis_id: 'val-1')
    expect(property.to_xml).to include('<c:axId val="cat-1"/><c:axId val="val-1"/>')
  end

  specify 'builds line chart property xml with series' do
    property.build_series(categories: ['A'], values: [1])

    xml = property.to_xml
    expect(xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
    expect(xml).to include('<c:val><c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit></c:val>')
  end
end
