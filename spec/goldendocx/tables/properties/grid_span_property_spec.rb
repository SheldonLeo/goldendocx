# frozen_string_literal: true

describe Goldendocx::Tables::Properties::GridSpanProperty do
  let(:property) { described_class.new }

  specify 'builds default grid span property xml' do
    expect(property.to_xml).to eq('<w:gridSpan/>')
  end

  specify 'builds customized grid span property xml' do
    property.span = 3
    expect(property.to_xml).to eq('<w:gridSpan w:val="3"/>')
  end
end
