# frozen_string_literal: true

describe Goldendocx::Images::Properties::ImageDataProperty do
  let(:property) { described_class.new }

  specify 'builds default image data property xml' do
    expect(property.to_xml).to eq('<v:imagedata/>')
  end

  specify 'builds customized image data property xml' do
    property.relationship_id = 'rId1'
    property.title = 'Image1.png'
    expect(property.to_xml).to eq('<v:imagedata r:id="rId1" o:title="Image1.png"/>')
  end
end
