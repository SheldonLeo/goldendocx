# frozen_string_literal: true

describe Goldendocx::Components::Properties::LanguageProperty do
  let(:property) { described_class.new }

  specify 'builds default language property xml' do
    expect(property.to_xml).to eq('<w:lang w:bidi="ar-SA" w:eastAsia="zh-CN" w:val="en-US"/>')
  end

  specify 'builds customized language property xml' do
    property.latin = 'en-HK'
    property.east_asia = 'zh-Hans'
    expect(property.to_xml).to eq('<w:lang w:bidi="ar-SA" w:eastAsia="zh-Hans" w:val="en-HK"/>')
  end
end
