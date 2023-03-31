# frozen_string_literal: true

require 'ox'
require_relative 'xml_to_class'

xml_fragment = File.read("#{Dir.pwd}/demo/templates/styles/reportTitle")
root_class = XmlToClass.new.parse(Ox.parse(xml_fragment))

root_class.write_rb('goldendocx/styles')
root_class.write_spec('goldendocx/styles')
