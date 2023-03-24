# frozen_string_literal: true

describe Goldendocx::Tables::HeaderCell do
  let(:header) { described_class.new(content: 'HeaderTitle') }

  describe '#to_xml' do
    let(:xml) { header.to_xml }

    it 'builds header element with default attributes' do
      expect(xml).to include('<w:vAlign w:val="center"/>')
      expect(xml).to include('<w:tcW w:type="auto"/>')
      expect(xml).to include('<w:shd w:val="clear" w:color="auto" w:fill="F5F5F5"/>')
    end

    it 'builds header with width' do
      header.width = 1000

      expect(xml).to include('<w:vAlign w:val="center"/>')
      expect(xml).to include('<w:tcW w:w="1000" w:type="dxa"/>')
      expect(xml).to include('<w:shd w:val="clear" w:color="auto" w:fill="F5F5F5"/>')
    end
  end
end
