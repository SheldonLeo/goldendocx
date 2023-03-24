# frozen_string_literal: true

describe Goldendocx::Images::Properties::DrawingProperty do
  let(:property) { described_class.new }

  specify 'builds default drawing property xml' do
    expect(property.to_xml).to eq('<pic:cNvPicPr/>')
  end
end
