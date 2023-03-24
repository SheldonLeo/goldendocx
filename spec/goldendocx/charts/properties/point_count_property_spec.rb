# frozen_string_literal: true

describe Goldendocx::Charts::Properties::PointCountProperty do
  let(:property) { described_class.new }

  specify 'builds default point count property xml' do
    expect(property.to_xml).to eq('<c:ptCount/>')
  end

  specify 'builds customized point count property xml' do
    property.count = 100
    expect(property.to_xml).to eq('<c:ptCount val="100"/>')
  end
end
