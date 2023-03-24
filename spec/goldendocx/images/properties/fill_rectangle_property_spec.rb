# frozen_string_literal: true

describe Goldendocx::Images::Properties::FillRectangleProperty do
  let(:property) { described_class.new }

  specify 'builds default fill rectangle property xml' do
    expect(property.to_xml).to eq('<a:fillRect/>')
  end
end
