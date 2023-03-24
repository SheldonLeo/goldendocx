# frozen_string_literal: true

describe Goldendocx::Charts::Properties::StringListProperty do
  let(:property) { described_class.new }

  specify 'builds default string list property xml' do
    expect(property.to_xml).to eq('<c:strLit><c:ptCount/></c:strLit>')
  end

  specify 'builds customized string list property xml' do
    property.build_count(count: 1)
    property.build_point(index: 0).build_value(value: 'OK')
    expect(property.to_xml).to eq('<c:strLit><c:ptCount val="1"/><c:pt idx="0"><c:v>OK</c:v></c:pt></c:strLit>')
  end
end
