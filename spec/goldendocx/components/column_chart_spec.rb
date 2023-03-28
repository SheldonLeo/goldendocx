# frozen_string_literal: true

describe Goldendocx::Components::ColumnChart do
  let(:attributes) { {} }
  let(:chart) { described_class.new(1, 'rId1', attributes) }

  describe '#to_xml' do
    let(:xml) { chart.to_xml }

    it 'builds column chart document.xml' do
      expect(xml).to include('<c:chart r:id="rId1"/>')
    end
  end

  describe '#to_document_xml' do
    let(:xml) { chart.to_document_xml }

    it 'builds column chart.xml' do
      chart.add_series('Ser1', ['A'], [1])

      expect(xml).to include('<c:barChart>')
      column_chart_xml = xml.match(%r{<c:barChart>(.*)</c:barChart>})[0]
      expect(column_chart_xml).to include('<c:barDir val="col"/>')
      expect(column_chart_xml).to include('<c:grouping val="clustered"/>')
      expect(column_chart_xml).to include('<c:axId val="9374902"/>')
      expect(column_chart_xml).to include('<c:axId val="2094739"/>')
      expect(column_chart_xml).to include('<c:cat><c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit></c:cat>')
      expect(column_chart_xml).to include('<c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit>')
    end
  end
end
