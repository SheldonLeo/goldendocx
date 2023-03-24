# frozen_string_literal: true

describe Goldendocx::Components::Text do
  let(:text) { described_class.new }

  describe '#to_xml' do
    let(:xml) { text.to_xml }

    it 'builds text xml' do
      text.text = 'Hello Word'
      text.color = 'F3E2DD'
      text.bold = true

      expect(xml).to include('<w:t>Hello Word</w:t>')
      expect(xml).to include('<w:color w:val="F3E2DD"/>')
      expect(xml).to include('<w:b w:val="true"/>')
    end
  end
end
