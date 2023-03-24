# frozen_string_literal: true

describe Goldendocx::Components::Image do
  context 'with picture' do
    let(:image) { described_class.new(type: :picture) }

    describe '#to_xml' do
      let(:xml) { image.to_xml }

      it 'draws image as picture' do
        image.relationship_id = 'rId2'
        image.width = 720000
        image.height = 360000

        expect(xml).to include('<wp:extent cx="720000" cy="360000"/>')
        expect(xml).to include('<pic:cNvPr id="rId2" name="rId2.png"/>')
      end
    end
  end

  context 'with shape' do
    let(:image) { described_class.new(type: :shape) }

    describe '#to_xml' do
      let(:xml) { image.to_xml }

      it 'draws image as shape' do
        image.relationship_id = 'rId3'
        image.width = 360000
        image.height = 720000

        expect(xml).to include('<v:shape style="height:2cm;width:1cm">')
        expect(xml).to include('<v:imagedata r:id="rId3"/>')
      end
    end
  end
end
