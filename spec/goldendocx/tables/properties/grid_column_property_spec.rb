# frozen_string_literal: true

describe Goldendocx::Tables::Properties::GridColumnProperty do
  let(:property) { described_class.new }

  specify 'builds default table grid property xml' do
    expect(property.to_xml).to eq('<w:gridCol w:w="600"/>')
  end

  specify 'builds customized table grid property xml' do
    property.width = 200
    expect(property.to_xml).to eq('<w:gridCol w:w="200"/>')
  end
end
