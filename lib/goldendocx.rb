# frozen_string_literal: true

require 'zip'
require 'extensions/active_support_extensions'

require 'goldendocx/version'

module Goldendocx
  autoload :Configuration, 'goldendocx/configuration'

  NAMESPACES = {
    a: 'http://schemas.openxmlformats.org/drawingml/2006/main',
    a14: 'http://schemas.microsoft.com/office/drawing/2010/main',
    c: 'http://schemas.openxmlformats.org/drawingml/2006/chart',
    c14: 'http://schemas.microsoft.com/office/drawing/2007/8/2/chart',
    cx: 'http://schemas.microsoft.com/office/drawing/2014/chartex',
    cx1: 'http://schemas.microsoft.com/office/drawing/2015/9/8/chartex',
    cx2: 'http://schemas.microsoft.com/office/drawing/2015/10/21/chartex',
    cx3: 'http://schemas.microsoft.com/office/drawing/2016/5/9/chartex',
    cx4: 'http://schemas.microsoft.com/office/drawing/2016/5/10/chartex',
    cx5: 'http://schemas.microsoft.com/office/drawing/2016/5/11/chartex',
    cx6: 'http://schemas.microsoft.com/office/drawing/2016/5/12/chartex',
    cx7: 'http://schemas.microsoft.com/office/drawing/2016/5/13/chartex',
    cx8: 'http://schemas.microsoft.com/office/drawing/2016/5/14/chartex',
    m: 'http://schemas.openxmlformats.org/officeDocument/2006/math',
    mc: 'http://schemas.openxmlformats.org/markup-compatibility/2006',
    mo: 'http://schemas.microsoft.com/office/mac/office/2008/main',
    mv: 'urn:schemas-microsoft-com:mac:vml',
    o: 'urn:schemas-microsoft-com:office:office',
    pic: 'http://schemas.openxmlformats.org/drawingml/2006/picture',
    r: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
    sl: 'http://schemas.openxmlformats.org/schemaLibrary/2006/main',
    v: 'urn:schemas-microsoft-com:vml',
    w: 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
    w10: 'urn:schemas-microsoft-com:office:word',
    w14: 'http://schemas.microsoft.com/office/word/2010/wordml',
    w15: 'http://schemas.microsoft.com/office/word/2012/wordml',
    w16cid: 'http://schemas.microsoft.com/office/word/2016/wordml/cid',
    w16se: 'http://schemas.microsoft.com/office/word/2015/wordml/symex',
    wne: 'http://schemas.microsoft.com/office/word/2006/wordml',
    wp: 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing',
    wp14: 'http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing',
    wpc: 'http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas',
    wpg: 'http://schemas.microsoft.com/office/word/2010/wordprocessingGroup',
    wpi: 'http://schemas.microsoft.com/office/word/2010/wordprocessingInk',
    wps: 'http://schemas.microsoft.com/office/word/2010/wordprocessingShape'
  }.freeze

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def xml_serializer
      @xml_serializer ||=
        begin
          case config.xml_serializer
          when :ox then require 'goldendocx/xml_serializers/ox'
          when :nokogiri then require 'goldendocx/xml_serializers/nokogiri'
          else raise StandardError, 'Unsupported XML serializer'
          end

          serializer_class = "Goldendocx::XmlSerializers::#{config.xml_serializer.to_s.capitalize}"
          Kernel.const_get(serializer_class)
        end
    end
  end
end

require 'goldendocx/units'
require 'goldendocx/element'
require 'goldendocx/document'
require 'goldendocx/has_associations'
require 'goldendocx/docx'
