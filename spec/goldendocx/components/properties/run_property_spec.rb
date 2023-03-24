# frozen_string_literal: true

describe Goldendocx::Components::Properties::RunProperty do
  let(:property) { described_class.new }

  specify 'builds default run property xml' do
    expect(property.to_xml).to eq('<w:rPr/>')
  end

  specify 'builds customized run property xml' do
    property.build_color(hex: '6C6C6C')
    property.build_bold(enabled: true)
    expect(property.to_xml).to eq('<w:rPr><w:color w:val="6C6C6C"/><w:b w:val="true"/></w:rPr>')
  end
end
