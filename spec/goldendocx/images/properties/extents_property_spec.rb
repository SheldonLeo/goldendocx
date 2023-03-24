# frozen_string_literal: true

describe Goldendocx::Images::Properties::ExtentsProperty do
  let(:property) { described_class.new }

  specify 'builds default extents property xml' do
    expect(property.to_xml).to eq('<a:ext/>')
  end

  specify 'builds customized extents property xml' do
    property.width = 200
    property.height = 300
    expect(property.to_xml).to eq('<a:ext cx="200" cy="300"/>')
  end
end
