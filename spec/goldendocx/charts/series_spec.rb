# frozen_string_literal: true

describe Goldendocx::Charts::Series do
  let(:categories) { [] }
  let(:values) { [] }
  let(:attributes) { {} }

  let(:series) { described_class.new(categories:, values:, **attributes) }

  describe '#to_xml' do
    let(:xml) { series.to_xml }

    before do
      categories << 'A'
      values << 1
      attributes[:id] = 1
      attributes[:name] = 'Series 1'
    end

    it 'builds basic properties of series' do
      expect(xml).to include('<c:idx val="1"/>')
      expect(xml).to include('<c:order val="1"/>')
      expect(xml).to include('<c:smooth/>')
      expect(xml).to include('<c:marker><c:symbol val="dot"/></c:marker>')
      expect(xml).to include('<c:dLbls><c:delete val="true"/></c:dLbls>')
    end

    it 'builds text of series' do
      expect(xml).to include('<c:tx><c:v>Series 1</c:v></c:tx>')
    end

    it 'builds categories of series' do
      expect(xml).to include('<c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>A</c:v></c:pt></c:strLit>')
    end

    it 'builds values of series' do
      expect(xml).to include('<c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit>')
    end
  end
end
