# frozen_string_literal: true

describe Goldendocx::Charts::Properties::PlotAreaProperty do
  let(:property) { described_class.new }

  specify 'builds default plot area property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
       <c:plotArea>
        <c:layout/>
        <c:catAx><c:axId val="9374902"/><c:crossAx val="2094739"/></c:catAx>
        <c:valAx><c:axId val="2094739"/><c:crossAx val="9374902"/></c:valAx>
      </c:plotArea>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end

  specify 'builds plot area property xml with layout' do
    property.build_layout
    expect(property.to_xml).to include('<c:layout/>')
  end

  specify 'builds plot area property xml with axes' do
    xml = property.to_xml
    expect(xml).to include('<c:catAx><c:axId val="9374902"/><c:crossAx val="2094739"/></c:catAx>')
    expect(xml).to include('<c:valAx><c:axId val="2094739"/><c:crossAx val="9374902"/></c:valAx>')
  end

  specify 'builds plot area property xml with line chart' do
    property.build_line_chart
    property.line_chart.build_axis(axis_id: 'cat-1')
    property.line_chart.build_axis(axis_id: 'val-1')
    property.line_chart.build_series(categories: ['A'], values: [1])

    xml = property.to_xml
    expect(xml).to match(%r{<c:lineChart>.*</c:lineChart>})

    line_chart_xml = xml.match(%r{<c:lineChart>.*</c:lineChart>}).string
    expect(line_chart_xml).to include('<c:axId val="cat-1"/><c:axId val="val-1"/>')
    expect(line_chart_xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
    expect(line_chart_xml).to include('<c:val><c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit></c:val>')
  end

  specify 'builds plot area property xml with bar chart' do
    property.build_bar_chart
    property.bar_chart.build_axis(axis_id: 'cat-1')
    property.bar_chart.build_axis(axis_id: 'val-1')
    property.bar_chart.build_series(categories: ['A'], values: [1])

    xml = property.to_xml
    expect(xml).to match(%r{<c:barChart>.*</c:barChart>})

    bar_chart_xml = xml.match(%r{<c:barChart>.*</c:barChart>}).string
    expect(bar_chart_xml).to include('<c:axId val="cat-1"/><c:axId val="val-1"/>')
    expect(bar_chart_xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
    expect(bar_chart_xml).to include('<c:val><c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit></c:val>')
  end

  specify 'builds plot area property xml with column chart' do
    property.build_column_chart
    property.column_chart.build_axis(axis_id: 'cat-1')
    property.column_chart.build_axis(axis_id: 'val-1')
    property.column_chart.build_series(categories: ['A'], values: [1])

    xml = property.to_xml
    expect(xml).to match(%r{<c:barChart>.*</c:barChart>})

    bar_chart_xml = xml.match(%r{<c:barChart>.*</c:barChart>}).string
    expect(bar_chart_xml).to include('<c:axId val="cat-1"/><c:axId val="val-1"/>')
    expect(bar_chart_xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
    expect(bar_chart_xml).to include('<c:val><c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit></c:val>')
  end

  specify 'builds plot area property xml with doughnut chart' do
    property.build_doughnut_chart
    property.doughnut_chart.build_series(categories: ['A'], values: [1])

    xml = property.to_xml
    expect(xml).to match(%r{<c:doughnutChart>.*</c:doughnutChart>})

    doughnut_chart_xml = xml.match(%r{<c:doughnutChart>.*</c:doughnutChart>}).string
    expect(doughnut_chart_xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
    expect(doughnut_chart_xml).to include('<c:val><c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit></c:val>')
  end
end
