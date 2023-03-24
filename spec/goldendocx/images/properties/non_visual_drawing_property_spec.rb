# frozen_string_literal: true

describe Goldendocx::Images::Properties::NonVisualDrawingProperty do
  let(:property) { described_class.new }

  specify 'builds default non visual drawing property xml' do
    expect(property.to_xml).to eq('<pic:cNvPr/>')
  end

  specify 'builds customized non visual drawing property xml' do
    property.relationship_id = 'rId1'
    property.name = 'Image1.png'
    expect(property.to_xml).to eq('<pic:cNvPr id="rId1" name="Image1.png"/>')
  end
end
