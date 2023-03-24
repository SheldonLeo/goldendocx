# frozen_string_literal: true

describe Goldendocx::Components::Properties::ColorProperty do
  let(:property) { described_class.new }

  specify 'builds default color property xml' do
    expect(property.to_xml).to eq('<w:color/>')
  end

  specify 'builds customized color property xml' do
    property.hex = '9F9F9F'
    expect(property.to_xml).to eq('<w:color w:val="9F9F9F"/>')
  end
end
