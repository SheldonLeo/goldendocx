# frozen_string_literal: true

describe Goldendocx::Documents::Properties::ParagraphDefaultStyleProperty do
  let(:property) { described_class.new }

  specify 'builds default paragraph default style property xml' do
    expect(property.to_xml).to eq('<w:pPrDefault/>')
  end
end
