# frozen_string_literal: true

describe Goldendocx::Components::Properties::BoldProperty do
  let(:property) { described_class.new }

  specify 'builds default bold property xml' do
    expect(property.to_xml).to eq('<w:b/>')
  end

  specify 'builds customized bold property xml' do
    property.enabled = true
    expect(property.to_xml).to eq('<w:b w:val="true"/>')
  end
end
