# frozen_string_literal: true

describe Goldendocx::Components::Properties::AlignProperty do
  let(:property) { described_class.new }

  specify 'builds default align property xml' do
    expect(property.to_xml).to eq('<w:jc/>')
  end

  specify 'builds customized align property xml' do
    property.align = :center
    expect(property.to_xml).to eq('<w:jc w:val="center"/>')
  end
end
