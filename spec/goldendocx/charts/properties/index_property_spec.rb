# frozen_string_literal: true

describe Goldendocx::Charts::Properties::IndexProperty do
  let(:property) { described_class.new }

  specify 'builds default index property xml' do
    expect(property.to_xml).to eq('<c:idx/>')
  end

  specify 'builds customized index property xml' do
    property.index = 1
    expect(property.to_xml).to eq('<c:idx val="1"/>')
  end
end
