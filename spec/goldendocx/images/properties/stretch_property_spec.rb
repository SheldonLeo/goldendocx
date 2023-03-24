# frozen_string_literal: true

describe Goldendocx::Images::Properties::StretchProperty do
  let(:property) { described_class.new }

  specify 'builds default stretch property xml' do
    expect(property.to_xml).to eq('<a:stretch><a:fillRect/></a:stretch>')
  end
end
