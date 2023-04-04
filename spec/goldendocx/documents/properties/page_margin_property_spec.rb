# frozen_string_literal: true

describe Goldendocx::Documents::Properties::PageMarginProperty do
  let(:property) { described_class.new }

  specify 'builds default page margin property xml' do
    expect(property.to_xml).to eq('<w:pgMar w:top="1440" w:bottom="1440" w:left="1800" w:right="1800" w:header="851" w:footer="992" w:gutter="0"/>')
  end

  specify 'builds customized page margin property xml' do
    property.margin = 0
    expect(property.to_xml).to eq('<w:pgMar w:top="0" w:bottom="0" w:left="0" w:right="0" w:header="851" w:footer="992" w:gutter="0"/>')

    property.margin = 10, 15
    expect(property.to_xml).to eq('<w:pgMar w:top="10" w:bottom="10" w:left="15" w:right="15" w:header="851" w:footer="992" w:gutter="0"/>')

    property.margin = 10, 5, 15
    expect(property.to_xml).to eq('<w:pgMar w:top="10" w:bottom="15" w:left="5" w:right="5" w:header="851" w:footer="992" w:gutter="0"/>')

    property.margin = 10, 5, 15, 20
    expect(property.to_xml).to eq('<w:pgMar w:top="10" w:bottom="15" w:left="20" w:right="5" w:header="851" w:footer="992" w:gutter="0"/>')
  end
end
