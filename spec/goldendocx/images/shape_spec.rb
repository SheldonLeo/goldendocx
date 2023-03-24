# frozen_string_literal: true

describe Goldendocx::Images::Shape do
  let(:shape) { described_class.new(relationship_id: 'rId1') }

  describe '#to_xml' do
    let(:xml) { shape.to_xml }

    it 'builds shape xml' do
      expect(xml).to include('<v:shape style="height:9.27cm;width:15cm">')
      expect(xml).to include('<v:imagedata r:id="rId1"/>')
    end
  end
end
