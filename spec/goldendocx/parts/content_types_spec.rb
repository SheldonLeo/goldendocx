# frozen_string_literal: true

describe Goldendocx::Parts::ContentTypes do
  let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }

  specify 'sets required defaults when initialized' do
    content_types = described_class.new
    expect(content_types.defaults.size).to eq(2)
    expect(content_types.defaults.map(&:extension)).to eq(%w[rels xml])

    expect(content_types.overrides.size).to eq(0)
  end

  describe '.read_from' do
    it 'reads from docx file and parse defaults and overrides' do
      content_types = described_class.read_from(docx_file)

      expect(content_types.defaults.size).to eq(2)
      expect(content_types.overrides.size).to eq(8)
    end
  end

  describe '#add_default' do
    let(:content_types) { described_class.new }

    it 'adds new node to defaults' do
      expect do
        content_types.add_default('png', 'image/png')
      end.to change { content_types.defaults.size }.by(1)
    end

    it 'not add node to defaults if already exists' do
      content_types.add_default('png', 'image/png')

      expect do
        content_types.add_default('png', 'image/png')
      end.to(not_change { content_types.defaults.size })
    end
  end

  describe '#add_override' do
    let(:content_types) { described_class.new }

    it 'adds new node to defaults' do
      expect do
        content_types.add_override('image1.png', 'image/png')
      end.to change { content_types.overrides.size }.by(1)
    end

    it 'not add node to defaults if already exists' do
      content_types.add_override('image1.png', 'image/png')

      expect do
        content_types.add_override('image1.png', 'image/png')
      end.to(not_change { content_types.overrides.size })
    end
  end

  describe '#to_document_xml' do
    let(:content_types) { described_class.new }

    it 'writes content types as xml' do
      content_types.add_default('xml', 'application/xml')
      content_types.add_default('png', 'image/png')

      xml = content_types.to_document_xml
      expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
          <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
          <Default Extension="xml" ContentType="application/xml"/>
          <Default Extension="png" ContentType="image/png"/>
        </Types>
      XML
      expect(xml).to eq(expected_xml)
    end
  end
end
