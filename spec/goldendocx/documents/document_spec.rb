# frozen_string_literal: true

describe Goldendocx::Documents::Document do
  let(:document) { described_class.new }
  let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }

  describe '#to_document_xml' do
    let(:xml) { document.to_document_xml }

    it 'builds default document.xml' do
      expected_xml = File.read('spec/fixtures/default_document.xml').delete("\n").gsub(/\s{4}/, ' ').gsub(/\s{2}/, '')
      expect(xml).to eq(expected_xml)
    end
  end

  it 'reads document.xml from docx file' do
    allow(document.body).to receive(:read_from).with(docx_file)

    document.read_from(docx_file)

    expect(document.body).to have_received(:read_from).with(docx_file).once
  end
end
