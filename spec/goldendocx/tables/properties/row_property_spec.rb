# frozen_string_literal: true

describe Goldendocx::Tables::Properties::RowProperty do
  let(:property) { described_class.new }

  specify 'builds default row property xml' do
    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
      <w:trPr>
        <w:trHeight w:val="600" w:hRule="atLeast"/>
      </w:trPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end

  specify 'builds customized row property xml' do
    property.build_height(height: 1000)

    expected_xml = <<~XML.gsub(/(^\s+)|\n/, '')
       <w:trPr>
        <w:trHeight w:val="1000" w:hRule="atLeast"/>
      </w:trPr>
    XML
    expect(property.to_xml).to eq(expected_xml)
  end
end
