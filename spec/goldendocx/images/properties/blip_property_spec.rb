# frozen_string_literal: true

describe Goldendocx::Images::Properties::BlipProperty do
  let(:property) { described_class.new }

  specify 'builds default blip property xml' do
    expect(property.to_xml).to eq('<a:blip/>')
  end

  specify 'builds customized blip property xml' do
    property.relationship_id = 'rId1'
    expect(property.to_xml).to eq('<a:blip r:embed="rId1"/>')
  end
end
