# frozen_string_literal: true

describe Goldendocx::Tables::Properties::WidthProperty do
  let(:property) { described_class.new }

  specify 'builds default table width property xml' do
    expect(property.to_xml).to eq('<w:tblW w:w="8600" w:type="dxa"/>')
  end

  specify 'builds customized table style property xml' do
    property.width = 5000
    expect(property.to_xml).to eq('<w:tblW w:w="5000" w:type="dxa"/>')

    property.type = :pct
    expect(property.to_xml).to eq('<w:tblW w:w="5000" w:type="pct"/>')
  end
end
