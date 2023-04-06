# frozen_string_literal: true

describe Goldendocx::Documents::Style do
  describe '.read_from' do
    let!(:style_fragment) do
      <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" ?>
        <w:style w:type="paragraph" w:styleId="2" w:default="1">
          <w:name w:val="Title"/>
          <w:qFormat/>
          <w:uiPriority w:val="0"/>
          <w:pPr>
            <w:keepNext/>
          </w:pPr>
          <w:rPr>
            <w:b/>
            <w:kern w:val="44"/>
            <w:sz w:val="44"/>
          </w:rPr>
        </w:style>
      XML
    end

    it 'reads styles from xml fragment' do
      style = described_class.parse(style_fragment)
      expect(style.unparsed_attributes).to eq('w:default' => '1')
      expect(style.unparsed_children.size).to eq(4)
    end
  end
end
