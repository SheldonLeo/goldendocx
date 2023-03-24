# frozen_string_literal: true

describe Goldendocx::Charts::Properties::LayoutProperty do
  let(:property) { described_class.new }

  specify 'builds default layout property xml' do
    expect(property.to_xml).to eq('<c:layout/>')
  end
end
