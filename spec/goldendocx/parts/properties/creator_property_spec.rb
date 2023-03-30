# frozen_string_literal: true

describe Goldendocx::Parts::Properties::CreatorProperty do
  let(:property) { described_class.new }

  specify 'builds default creator property xml' do
    expect(property.to_xml).to eq('<dc:creator/>')
  end

  specify 'builds customized creator property xml' do
    property.name = 'Goldendocx'
    expect(property.to_xml).to eq('<dc:creator>Goldendocx</dc:creator>')
  end
end
