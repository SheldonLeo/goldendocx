# frozen_string_literal: true

describe Goldendocx::Tables::Row do
  let(:row) { described_class.new }

  describe '#add_cell' do
    let(:cell) { Goldendocx::Tables::Cell.new(content: 'Cell') }

    it 'adds cell to row cells' do
      expect do
        row.add_cell(cell)
      end.to change { row.cells.size }.by(1)
    end
  end

  describe '#to_xml' do
    let(:xml) { row.to_xml }

    it 'builds default row element' do
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <w:tr>
          <w:trPr><w:trHeight w:val="600" w:hRule="atLeast"/></w:trPr>
        </w:tr>
      XML
      expect(xml).to eq(expected_xml)
    end

    it 'builds default row element with cells' do
      row.height = 700
      row.build_cell content: 'Cell1'
      row.add_cell Goldendocx::Tables::Cell.new(content: 'Cell2')

      expect(xml).to include('<w:trHeight w:val="700" w:hRule="atLeast"/>')
      expect(xml).to include('<w:vAlign w:val="center"/>')
      expect(xml).to include('<w:r><w:t>Cell1</w:t></w:r>')
      expect(xml).to include('<w:r><w:t>Cell2</w:t></w:r>')
    end
  end
end
