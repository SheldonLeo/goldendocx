# frozen_string_literal: true

describe Goldendocx::Images::Picture do
  let(:picture) { described_class.new(relationship_id: 'rId1', width: 300, height: 300) }

  describe '#to_xml' do
    let(:xml) { picture.to_xml }

    it 'builds picture element' do
      expect(xml).to include('<pic:cNvPr id="rId1" name="rId1.png"/>')
      expect(xml).to include('<pic:cNvPicPr/>')
      expect(xml).to include('<a:blip r:embed="rId1"/>')
      expect(xml).to include('<a:xfrm><a:ext cx="300" cy="300"/></a:xfrm>')
    end
  end
end
