# frozen_string_literal: true

describe Goldendocx::Charts::CategoryAxis do
  let(:property) { described_class.new }

  specify 'builds default category axis property xml' do
    expect(property.to_xml).to eq('<c:catAx><c:axId val="9374902"/><c:crossAx val="2094739"/></c:catAx>')
  end

  specify 'builds customized category axis property xml' do
    property.axis_id.axis_id = 'cat-1'
    property.cross_axis.axis_id = 'val-1'
    expect(property.to_xml).to eq('<c:catAx><c:axId val="cat-1"/><c:crossAx val="val-1"/></c:catAx>')
  end
end
