# frozen_string_literal: true

describe Goldendocx::Parts::Properties::UpdaterProperty do
  let(:property) { described_class.new }

  specify 'builds default updater property xml' do
    expect(property.to_xml).to eq('<dc:lastModifiedBy/>')
  end

  specify 'builds customized updater property xml' do
    property.name = 'Goldendocx'
    expect(property.to_xml).to eq('<dc:lastModifiedBy>Goldendocx</dc:lastModifiedBy>')
  end
end
