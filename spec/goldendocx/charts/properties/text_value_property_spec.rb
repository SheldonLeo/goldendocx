# frozen_string_literal: true

describe Goldendocx::Charts::Properties::TextValueProperty do
  let(:property) { described_class.new }

  specify 'builds default text value property xml' do
    expect(property.to_xml).to eq('<c:v/>')
  end

  specify 'builds customized text value property xml' do
    property.value = 'Hello'
    expect(property.to_xml).to eq('<c:v>Hello</c:v>')

    property.value = 2014
    expect(property.to_xml).to eq('<c:v>2014</c:v>')
  end
end
