# frozen_string_literal: true

describe Goldendocx::Components::Paragraph do
  let(:paragraph) { described_class.new }

  describe '#to_xml' do
    let(:xml) { paragraph.to_xml }

    specify 'builds default paragraph xml' do
      expect(xml).to eq('<w:p><w:pPr><w:pStyle/><w:jc/></w:pPr></w:p>')
    end

    context 'with properties' do
      it 'builds paragraph xml with property' do
        paragraph.align = :center
        paragraph.style = 'style_id'

        expect(xml).to include('<w:pStyle w:val="style_id"/>')
        expect(xml).to include('<w:jc w:val="center"/>')
      end
    end

    context 'with runs' do
      it 'builds paragraph xml with a text run' do
        run = paragraph.build_run
        run.build_text.value = 'Hello World'

        expect(xml).to include('<w:r><w:t>Hello World</w:t></w:r>')
      end

      it 'builds paragraph xml with a shape run' do
        paragraph.build_run.build_shape(relationship_id: 'rId1')

        expect(xml).to include('<v:imagedata r:id="rId1"/>')
      end

      it 'builds paragraph xml with mixed type' do
        paragraph.build_run.build_shape(relationship_id: 'rId1')
        paragraph.build_run.build_text.value = 'Hello World'

        expect(xml).to include('<w:r><w:t>Hello World</w:t></w:r>')
        expect(xml).to include('<v:imagedata r:id="rId1"/>')
      end
    end
  end
end
