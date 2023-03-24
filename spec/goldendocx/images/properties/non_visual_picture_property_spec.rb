# frozen_string_literal: true

describe Goldendocx::Images::Properties::NonVisualPictureProperty do
  let(:property) { described_class.new }

  specify 'builds default non visual picture property xml' do
    expect(property.to_xml).to eq('<pic:nvPicPr><pic:cNvPr/></pic:nvPicPr>')
  end

  specify 'builds customized non visual picture property xml' do
    property.non_visual_drawing.assign_attributes(relationship_id: 'rId1', name: 'Image1.png')
    expect(property.to_xml).to eq('<pic:nvPicPr><pic:cNvPr id="rId1" name="Image1.png"/></pic:nvPicPr>')
  end
end
