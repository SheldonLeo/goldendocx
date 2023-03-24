# frozen_string_literal: true

describe Goldendocx::Components::Properties::Textual do
  let(:property) { described_class.new }

  specify 'builds default run property xml' do
    expect(property.to_xml).to eq('<w:t/>')
  end

  specify 'builds customized run property xml' do
    property.value = 'Hello'
    expect(property.to_xml).to eq('<w:t>Hello</w:t>')
  end
end
