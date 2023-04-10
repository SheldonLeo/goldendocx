# frozen_string_literal: true

describe Goldendocx::Docx do
  let(:docx) { described_class.new }

  context 'when read from docx' do
    let(:docx_path) { 'spec/fixtures/BlankDocxTemplate.docx' }
    let(:docx_file) { Zip::File.new(docx_path) }
    let(:docx) { described_class.new.read_from(docx_path) }

    it 'load entries at word/' do
      expect(docx.documents).to be_a(Goldendocx::Parts::Documents)
    end

    it 'load [Content_Types].xml' do
      expect(docx.content_types).to be_a(Goldendocx::Parts::ContentTypes)
    end

    describe '#write_to' do
      let(:image) { File.open('spec/fixtures/docx.png') }

      it 'writes with exactly same entries' do
        new_path = Tempfile.new(%w[newDocument .docx]).path
        expect { docx.write_to(new_path) }.not_to raise_error

        new_entries = Zip::File.new(new_path).entries.map(&:name)
        expect(new_entries).to match_array(docx_file.entries.map(&:name))
      end

      it 'writes medias entries if has any' do
        new_path = Tempfile.new(%w[newDocument .docx]).path
        expect do
          docx.create_image(image)
          docx.write_to(new_path)
        end.not_to raise_error

        new_entries = Zip::File.new(new_path).entries.map(&:name)
        expect(new_entries).to match_array(docx_file.entries.map(&:name) + ['word/media/image1.png'])
      end

      it 'writes charts entries if has any' do
        new_path = Tempfile.new(%w[newDocument .docx]).path
        expect do
          docx.create_chart(:line)
          docx.write_to(new_path)
        end.not_to raise_error

        new_entries = Zip::File.new(new_path).entries.map(&:name)
        expect(new_entries).to match_array(docx_file.entries.map(&:name) + ['word/charts/chart1.xml'])
      end
    end
  end

  describe '#create_text' do
    let(:document) { docx.documents.document }

    it 'appends text on word document' do
      allow(document.body).to receive(:create_text)

      docx.create_text('Hello World!')
      expect(document.body).to have_received(:create_text).once
    end
  end

  describe '#create_table' do
    let(:document) { docx.documents.document }
    let(:image) { File.open('spec/fixtures/docx.png') }

    it 'creates table on word document' do
      expect do
        table = docx.create_table
        expect(table).to be_a(Goldendocx::Components::Table)
      end.to change { document.body.components.size }.by(1)
    end

    it 'creates table with embed image on word document' do
      expect do
        embed_image = docx.create_embed_image(image, width: 5000)
        table = docx.create_table
        table.add_row([Goldendocx::Tables::ImageCell.new(image: embed_image)])
        expect(table).to be_a(Goldendocx::Components::Table)
      end.to change { document.body.components.size }.by(1)
    end
  end

  describe '#create_image' do
    let(:documents) { docx.documents }
    let(:image) { File.open('spec/fixtures/docx.png') }

    it 'appends image on word document' do
      expect do
        docx.create_image(image)
      end.to change { documents.medias.size }.by(1) \
         .and change(documents, :media_amount).by(1) \
         .and change { documents.relationships.size }.by(1)
    end
  end

  describe '#create_embed_image' do
    let(:documents) { docx.documents }
    let(:image) { File.open('spec/fixtures/docx.png') }

    it 'not appends image on word document if not used' do
      expect do
        docx.create_embed_image(image)
      end.to change { documents.medias.size }.by(1) \
         .and change(documents, :media_amount).by(1) \
         .and change { documents.relationships.size }.by(1) \
         .and(not_change { documents.document.body.components.size })
    end
  end

  describe '#add_style' do
    let(:documents) { docx.documents }

    it 'appends image on word document' do
      allow(documents).to receive(:add_style)

      docx.add_style('style_path')
      expect(documents).to have_received(:add_style).once
    end
  end

  describe '#create_chart' do
    let(:documents) { docx.documents }
    let(:content_types) { docx.content_types }

    it 'creates chart on word document' do
      allow(documents).to receive(:create_chart).and_call_original

      expect do
        docx.create_chart(:line)
      end.to change { content_types.overrides.size }.by(1)

      expect(documents).to have_received(:create_chart).once
    end

    it 'raises error if chart type invalid' do
      expect { docx.create_chart(:ring) }.to raise_error(Goldendocx::Charts::InvalidChartType)
    end
  end
end
