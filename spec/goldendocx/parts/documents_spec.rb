# frozen_string_literal: true

describe Goldendocx::Parts::Documents do
  let(:documents) { described_class.new }

  describe '.read_from' do
    let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }

    it 'reads from exist docx file' do
      documents = described_class.read_from(docx_file)

      expect(documents.document).not_to be_nil
      expect(documents.styles).not_to be_nil
      expect(documents.relationships).not_to be_nil
    end
  end

  describe '#create_text' do
    let(:content_xml) { documents.document.to_document_xml }

    it 'appends text to body' do
      expect do
        documents.create_text('Hello World')
      end.to change { documents.document.body.components.size }.by(1)

      expect(content_xml).to include('<w:t>Hello World</w:t>')
    end

    it 'appends styled text' do
      documents.add_style(File.read('spec/fixtures/styles/text_fragment'))

      expect do
        documents.create_text('Hello World', style: 'Title', align: :center)
      end.to change { documents.document.body.components.size }.by(1)

      expect(content_xml).to include('<w:pStyle w:val="1"/>')
      expect(content_xml).to include('<w:jc w:val="center"/>')
      expect(content_xml).to include('<w:t>Hello World</w:t>')
    end
  end

  describe '#create_table' do
    let(:content_xml) { documents.document.to_document_xml }

    let(:headers) { %w[Name Brand Color] }
    let(:rows) { [%w[A B C]] }

    it 'creates table to body' do
      expect do
        table = documents.create_table
        expect(table).to be_a(Goldendocx::Components::Table)
      end.to change { documents.document.body.components.size }.by(1)
    end

    it 'creates styled table' do
      style_id = documents.add_style(File.read('spec/fixtures/styles/table_fragment'))

      expect do
        documents.create_table(style: 'Normal Table', width: 5000)
      end.to change { documents.document.body.components.size }.by(1)

      expect(content_xml).to include("<w:tblStyle w:val=\"#{style_id}\"/>")
      expect(content_xml).to include('<w:tblW w:w="5000" w:type="dxa"/>')
    end
  end

  context 'with relationships' do
    let(:documents) { described_class.new }

    describe '#add_relationship' do
      it 'adds relationship for documents' do
        expect do
          relationship_id = documents.relationships.add_relationship(
            'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image',
            'word/media/image1.png'
          )
          expect(relationship_id).to eq('rId2')
        end.to change { documents.relationships.size }.by(1)
      end
    end

    describe '#relationships_xml' do
      before do
        documents.relationships.add_relationship(
          'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image',
          'word/media/image1.png'
        )
      end

      it 'composes relationship documents xml' do
        xml = documents.relationships.to_document_xml
        image_relationship = <<~REL.strip
          <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="word/media/image1.png"/>
        REL
        expect(xml).to include(image_relationship)
      end
    end
  end

  context 'with styles' do
    let(:documents) { described_class.new }

    describe '#add_style' do
      let(:style_fragment) { File.read('spec/fixtures/styles/text_fragment') }

      it 'adds new style' do
        expect do
          documents.add_style(style_fragment)
        end.to change { documents.styles.size }.by(1)
      end
    end

    describe 'styles_xml' do
      before do
        documents.add_style('<w:style w:type="paragraph" w:styleId="1"><w:name w:val="Title"/></w:style>')
      end

      it 'composes styles documents xml' do
        xml = documents.styles.to_document_xml

        expect(xml).to include('<w:style w:styleId="1" w:type="paragraph"><w:name w:val="Title"/></w:style>')
      end
    end
  end
end
