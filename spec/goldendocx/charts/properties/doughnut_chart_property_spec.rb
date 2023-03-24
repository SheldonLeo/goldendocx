# frozen_string_literal: true

describe Goldendocx::Charts::Properties::DoughnutChartProperty do
  let(:property) { described_class.new }

  specify 'builds default `doughnut` chart property xml' do
    expect(property.to_xml).to eq('<c:doughnutChart><c:holeSize val="60"/></c:doughnutChart>')
  end

  specify 'builds doughnut chart property xml with series' do
    property.build_series(categories: ['A'], values: [1])

    xml = property.to_xml
    expect(xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
    expect(xml).to include('<c:val><c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit></c:val>')
  end
end
