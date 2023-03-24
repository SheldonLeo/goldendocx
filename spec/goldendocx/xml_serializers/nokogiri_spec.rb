# frozen_string_literal: true

require 'goldendocx/xml_serializers/nokogiri'

describe Goldendocx::XmlSerializers::Nokogiri, :xml_serializer do
  it_behaves_like 'with xml serializer'
end
