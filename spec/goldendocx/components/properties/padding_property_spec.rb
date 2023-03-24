# frozen_string_literal: true

describe Goldendocx::Components::Properties::PaddingProperty do
  let(:property) { described_class.new }

  specify 'builds default padding property xml' do
    expect(property.to_xml).to eq('<wp:effectExtent l="0" r="0" t="0" b="0"/>')
  end

  specify 'builds image padding property xml' do
    property.assign_attributes(left: 10, top: 20)

    expect(property.to_xml).to include('<wp:effectExtent l="10" r="0" t="20" b="0"/>')
  end
end
