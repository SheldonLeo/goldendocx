# frozen_string_literal: true

describe Goldendocx::Tables::Properties::CellWidthProperty do
  let(:property) { described_class.new }

  specify 'builds default cell width property xml' do
    expect(property.to_xml).to eq('<w:tcW w:type="auto"/>')
  end

  specify 'builds customized cell width property xml' do
    property.width = 200
    property.type = :dxa
    expect(property.to_xml).to eq('<w:tcW w:w="200" w:type="dxa"/>')
  end
end
