# frozen_string_literal: true

describe Goldendocx::Components::Properties::Run do
  let(:property) { described_class.new }

  specify 'builds default run property xml' do
    expect(property.to_xml).to eq('<w:r/>')
  end

  specify 'builds text run property xml' do
    property.build_text.value = 'Hello'
    expect(property.to_xml).to eq('<w:r><w:t>Hello</w:t></w:r>')
  end
end
