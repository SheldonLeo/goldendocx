# frozen_string_literal: true

describe Goldendocx::Charts::Properties::OrderProperty do
  let(:property) { described_class.new }

  specify 'builds default order property xml' do
    expect(property.to_xml).to eq('<c:order/>')
  end

  specify 'builds customized order property xml' do
    property.order = 1
    expect(property.to_xml).to eq('<c:order val="1"/>')
  end
end
