# frozen_string_literal: true

describe Goldendocx::Components::Properties::FontProperty do
  let(:property) { described_class.new }

  specify 'builds default color property xml' do
    expect(property.to_xml).to eq('<w:rFonts w:ascii="Times New Roman" w:eastAsia="宋体" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>')
  end

  specify 'builds customized color property xml' do
    property.ascii = 'Arial'
    property.east_asia = '黑体'
    expect(property.to_xml).to eq('<w:rFonts w:ascii="Arial" w:eastAsia="黑体" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>')
  end
end
