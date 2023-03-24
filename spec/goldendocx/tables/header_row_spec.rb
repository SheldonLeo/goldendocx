# frozen_string_literal: true

describe Goldendocx::Tables::HeaderRow do
  let(:header) { described_class.new }

  describe '#to_xml' do
    let(:xml) { header.to_xml }

    it 'builds header row element' do
      expect(xml).to include('<w:trHeight w:val="600" w:hRule="atLeast"/>')
      expect(xml).to include('<w:tblHeader/>')
    end
  end
end
