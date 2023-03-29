# frozen_string_literal: true

describe Goldendocx::Models::Relationships do
  let(:document) { Goldendocx::Parts::Documents.new }
  let(:relationships) { document.relationships }

  describe '#read_from' do
    let(:docx_file) { Zip::File.new('spec/fixtures/BlankDocxTemplate.docx') }

    it 'reads relationships from docx file' do
      expect do
        relationships.read_from(docx_file)
      end.to change { relationships.relationships.size }.by(4)
    end
  end
end
