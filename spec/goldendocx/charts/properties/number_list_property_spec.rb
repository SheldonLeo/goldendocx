# frozen_string_literal: true

describe Goldendocx::Charts::Properties::NumberListProperty do
  let(:property) { described_class.new }

  specify 'builds default number list property xml' do
    expect(property.to_xml).to eq('<c:numLit><c:ptCount/></c:numLit>')
  end

  specify 'builds customized number list property xml' do
    property.build_count(count: 1)
    property.build_point(index: 0).build_value(value: 1)
    expect(property.to_xml).to eq('<c:numLit><c:ptCount val="1"/><c:pt idx="0"><c:v>1</c:v></c:pt></c:numLit>')
  end
end
