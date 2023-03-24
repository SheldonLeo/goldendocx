# frozen_string_literal: true

describe Goldendocx::Tables::Properties::StyleProperty do
  let(:property) { described_class.new }

  specify 'builds default table style property xml' do
    expect(property.to_xml).to eq('<w:tblStyle/>')
  end

  specify 'builds customized table style property xml' do
    property.style_id = 'style_id'
    expect(property.to_xml).to eq('<w:tblStyle w:val="style_id"/>')
  end
end
