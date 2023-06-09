# frozen_string_literal: true

module Goldendocx
  module Parts
    class App
      include Goldendocx::Document

      TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties'
      XML_PATH = 'docProps/app.xml'
      NAMESPACE = 'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties'
      CONTENT_TYPE = 'application/vnd.openxmlformats-officedocument.extended-properties+xml'

      tag :Properties
      attribute :xmlns, default: NAMESPACE, readonly: true

      class << self
        def read_from(app_document)
          new_instance = new

          app_document.children.map do |node|
            new_instance.properties[node.name.to_sym] = node.text
          end

          new_instance
        end
      end

      def write_to(zos)
        zos.put_next_entry XML_PATH
        zos.write to_document_xml
      end

      def to_document_xml
        super do |xml|
          properties.each do |name, value|
            xml << Goldendocx.xml_serializer.build_element(name).tap { |app| app << value }
          end
        end
      end

      def properties
        @properties ||= { Application: "Goldendocx_#{Goldendocx::VERSION}" }
      end
    end
  end
end
