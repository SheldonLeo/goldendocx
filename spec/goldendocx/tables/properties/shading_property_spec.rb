# frozen_string_literal: true

describe Goldendocx::Tables::Properties::ShadingProperty do
  let(:property) { described_class.new }

  specify 'builds default shading property xml' do
    expect(property.to_xml).to eq('<w:shd/>')
  end

  specify 'builds customized shading property xml' do
    property.assign_attributes(value: :clear, color: :auto, fill: 'F5F5F5')
    expect(property.to_xml).to eq('<w:shd w:val="clear" w:color="auto" w:fill="F5F5F5"/>')
  end
end
