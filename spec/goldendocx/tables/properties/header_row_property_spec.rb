# frozen_string_literal: true

describe Goldendocx::Tables::Properties::HeaderRowProperty do
  let(:property) { described_class.new }

  specify 'builds default header row property xml' do
    expect(property.to_xml).to eq('<w:tblHeader/>')
  end
end
