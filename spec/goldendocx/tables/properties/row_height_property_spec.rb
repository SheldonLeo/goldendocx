# frozen_string_literal: true

describe Goldendocx::Tables::Properties::RowHeightProperty do
  let(:property) { described_class.new }

  specify 'builds default table width property xml' do
    expect(property.to_xml).to eq('<w:trHeight w:val="600" w:hRule="atLeast"/>')
  end

  specify 'builds customized table style property xml' do
    property.height = 800
    expect(property.to_xml).to eq('<w:trHeight w:val="800" w:hRule="atLeast"/>')
  end
end
