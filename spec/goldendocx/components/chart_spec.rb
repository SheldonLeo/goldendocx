# frozen_string_literal: true

describe Goldendocx::Components::Chart do
  let(:attributes) { {} }
  let(:chart) { described_class.new(1, 'rId1', attributes) }

  describe '#to_xml' do
    let(:xml) { chart.to_xml }

    it 'returns element to build document content' do
      expect(xml).to include('<c:chart r:id="rId1"/>')
    end
  end

  describe '#to_document_xml' do
    let(:xml) { chart.to_document_xml }

    it 'includes axes definitions' do
      expect(xml).to include('<c:catAx><c:axId val="9374902"/><c:crossAx val="2094739"/></c:catAx>')
      expect(xml).to include('<c:valAx><c:axId val="2094739"/><c:crossAx val="9374902"/></c:valAx>')
    end
  end
end
