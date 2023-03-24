# frozen_string_literal: true

describe Goldendocx::Tables::ImageCell do
  let(:image) { Goldendocx::Components::Image.new(relationship_id: 'rId1') }
  let(:cell) { described_class.new(image: image) }

  describe '#to_xml' do
    let(:xml) { cell.to_xml }

    it 'builds cell with image' do
      # expect(element_xml).to include('<pic:cNvPr id="rId1" name="rId1.png"/>')
      expect(xml).to include('<v:imagedata r:id="rId1"/>')
    end

    it 'builds cell with image and content' do
      cell.content = 'Hello'
      # expect(element_xml).to include('<pic:cNvPr id="rId1" name="rId1.png"/>')
      expect(xml).to include('<v:imagedata r:id="rId1"/>')
      expect(xml).to include('<w:r><w:t>Hello</w:t></w:r>')
    end
  end
end
