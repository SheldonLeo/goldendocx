# frozen_string_literal: true

describe Goldendocx::Images::Properties::ShapeProperty do
  let(:property) { described_class.new }

  specify 'builds default shape property xml' do
    expect(property.to_xml).to eq('<v:shape style="height:9.27cm;width:15cm"><v:imagedata/></v:shape>')
  end

  specify 'builds customized shape property xml' do
    property.width = 360000
    property.height = 720000
    expect(property.to_xml).to eq('<v:shape style="height:2cm;width:1cm"><v:imagedata/></v:shape>')
  end
end
