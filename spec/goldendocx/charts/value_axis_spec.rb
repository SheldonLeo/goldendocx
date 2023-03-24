# frozen_string_literal: true

describe Goldendocx::Charts::ValueAxis do
  let(:property) { described_class.new }

  specify 'builds default value axis property xml' do
    expect(property.to_xml).to eq('<c:valAx><c:axId val="2094739"/><c:crossAx val="9374902"/></c:valAx>')
  end

  specify 'builds customized value axis property xml' do
    property.axis_id.axis_id = 'vat-1'
    property.cross_axis.axis_id = 'cal-1'
    expect(property.to_xml).to eq('<c:valAx><c:axId val="vat-1"/><c:crossAx val="cal-1"/></c:valAx>')
  end
end
