# frozen_string_literal: true

describe Goldendocx::Components::Properties::StyleProperty do
  let(:property) { described_class.new }

  specify 'builds default style property xml' do
    expect(property.to_xml).to eq('<w:pStyle/>')
  end

  specify 'builds customized style property xml' do
    property.style_id = 'style_id'
    expect(property.to_xml).to eq('<w:pStyle w:val="style_id"/>')
  end
end
