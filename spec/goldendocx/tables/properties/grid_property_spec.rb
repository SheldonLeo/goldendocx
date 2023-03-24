# frozen_string_literal: true

describe Goldendocx::Tables::Properties::GridProperty do
  let(:property) { described_class.new }

  specify 'builds table grid xml' do
    property.build_grid_column
    property.build_grid_column(width: 300)
    property.build_grid_column(width: 715)

    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:tblGrid>
        <w:gridCol w:w="600"/>
        <w:gridCol w:w="300"/>
        <w:gridCol w:w="715"/>
      </w:tblGrid>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end
end
