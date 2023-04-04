# frozen_string_literal: true

describe Goldendocx::Documents::Properties::PageSizeProperty do
  let(:property) { described_class.new }

  specify 'builds default page size property xml' do
    expect(property.to_xml).to eq('<w:pgSz w:w="11906" w:h="16838"/>')
  end

  specify 'builds customized page size property xml' do
    property.height = '15000'
    expect(property.to_xml).to eq('<w:pgSz w:w="11906" w:h="15000"/>')
  end
end
