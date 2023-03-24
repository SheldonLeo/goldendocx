# frozen_string_literal: true

describe Goldendocx::Components::Properties::GraphicDataProperty do
  let(:property) { described_class.new }

  specify 'builds default graphic data property xml' do
    expect(property.to_xml).to eq('<a:graphicData/>')
  end

  specify 'builds image graphic data property xml' do
    property.build_picture(relationship_id: 'rId1')

    expect(property.to_xml).to include('<pic:cNvPr id="rId1" name="rId1.png"/>')
  end
end
