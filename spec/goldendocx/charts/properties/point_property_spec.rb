# frozen_string_literal: true

describe Goldendocx::Charts::Properties::PointProperty do
  let(:property) { described_class.new }

  specify 'builds default point property xml' do
    expect(property.to_xml).to eq('<c:pt/>')
  end

  specify 'builds customized point property xml' do
    property.index = 1
    property.build_value(value: 'Hello')
    expect(property.to_xml).to eq('<c:pt idx="1"><c:v>Hello</c:v></c:pt>')
  end
end
