# frozen_string_literal: true

describe Goldendocx::Tables::Cell do
  let(:cell) { described_class.new(content: 'PlainText') }

  describe '#to_xml' do
    let(:xml) { cell.to_xml }

    it 'builds cell element' do
      expect(xml).to include('<w:vAlign w:val="center"/>')
      expect(xml).to include('<w:r><w:t>PlainText</w:t></w:r>')
    end

    it 'builds cell element with span and align' do
      cell.span = 2
      cell.align = :center

      expect(xml).to include('<w:gridSpan w:val="2"/>')
      expect(xml).to include('<w:jc w:val="center"/>')
    end
  end
end
