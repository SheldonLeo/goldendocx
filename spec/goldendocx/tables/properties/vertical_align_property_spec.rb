# frozen_string_literal: true

describe Goldendocx::Tables::Properties::VerticalAlignProperty do
  let(:property) { described_class.new }

  specify 'builds default align property xml' do
    expect(property.to_xml).to eq('<w:vAlign w:val="center"/>')
  end

  specify 'builds customized align property xml' do
    property.align = :left
    expect(property.to_xml).to eq('<w:vAlign w:val="left"/>')
  end
end
