# frozen_string_literal: true

describe Goldendocx::Parts::Properties::CreatedAtProperty do
  let(:property) { described_class.new }

  specify 'builds default created at property xml' do
    expect(property.to_xml).to eq('<dcterms:created xsi:type="dcterms:W3CDTF"/>')
  end

  specify 'builds customized created at property xml' do
    property.timestamp = Time.local(1992, 7, 11)
    expect(property.to_xml).to eq('<dcterms:created xsi:type="dcterms:W3CDTF">1992-07-11T00:00:00Z</dcterms:created>')
  end
end
