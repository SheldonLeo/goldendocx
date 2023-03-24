# frozen_string_literal: true

describe Goldendocx::Images::Properties::TransformProperty do
  let(:property) { described_class.new }

  specify 'builds default transfer property xml' do
    expect(property.to_xml).to eq('<a:xfrm><a:ext/></a:xfrm>')
  end

  specify 'builds customized transfer property xml' do
    property.build_extents(width: 100, height: 200)
    expect(property.to_xml).to eq('<a:xfrm><a:ext cx="100" cy="200"/></a:xfrm>')
  end
end
