# frozen_string_literal: true

describe Goldendocx::Components::DoughnutChart do
  let(:attributes) { {} }
  let(:chart) { described_class.new(1, 'rId1', attributes) }

  describe '#to_xml' do
    let(:xml) { chart.to_xml }

    it 'builds doughnut chart document.xml' do
      expect(xml).to include('<c:chart r:id="rId1"/>')
    end
  end

  describe '#to_document_xml' do
    let(:xml) { chart.to_document_xml }

    it 'builds doughnut chart.xml' do
      chart.add_series('Ser1', ['A'], [1])

      expect(xml).to include('<c:doughnutChart>')
      doughnut_chart_xml = xml.match(%r{<c:doughnutChart>(.*)</c:doughnutChart>})[0]
      expect(doughnut_chart_xml).to include('<c:holeSize val="60"/>')
      expect(doughnut_chart_xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
      expect(doughnut_chart_xml).to include('<c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit>')
    end
  end
end
