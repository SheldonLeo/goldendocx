# frozen_string_literal: true

describe Goldendocx::Components::Properties::GraphicFrameLocksProperty do
  let(:property) { described_class.new }

  specify 'builds default locks property xml' do
    expect(property.to_xml).to eq('<a:graphicFrameLocks noMove="true" noResize="true" noChangeAspect="true"/>')
  end

  specify 'builds customized locks property xml' do
    property.lock_aspect = false
    property.lock_size = false
    expect(property.to_xml).to eq('<a:graphicFrameLocks noMove="true" noResize="true" noChangeAspect="true"/>')
  end
end
