# frozen_string_literal: true

describe Goldendocx::Charts::Properties::SmoothProperty do
  let(:property) { described_class.new }

  specify 'builds default smooth property xml' do
    expect(property.to_xml).to eq('<c:smooth/>')
  end
end
