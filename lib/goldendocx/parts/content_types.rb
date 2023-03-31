# frozen_string_literal: true

require 'goldendocx/content_types/default'
require 'goldendocx/content_types/override'

module Goldendocx
  module Parts
    class ContentTypes
      include Goldendocx::Document

      XML_PATH = '[Content_Types].xml'
      NAMESPACE = 'http://schemas.openxmlformats.org/package/2006/content-types'

      REQUIRED_DEFAULTS = {
        rels: 'application/vnd.openxmlformats-package.relationships+xml',
        xml: 'application/xml'
      }.freeze

      attr_reader :defaults, :overrides

      tag :Types
      attribute :xmlns, default: NAMESPACE, readonly: true

      class << self
        def read_from(docx_file)
          content_types = Goldendocx::Parts::ContentTypes.new
          content_types.read_defaults(docx_file)
          content_types.read_overrides(docx_file)
          content_types
        end
      end

      def initialize
        @defaults = REQUIRED_DEFAULTS.map do |extension, content_type|
          Goldendocx::ContentTypes::Default.new(extension, content_type)
        end
        @overrides = []
      end

      def read_defaults(docx_file)
        @defaults = Goldendocx.xml_serializer.parse(docx_file.read(XML_PATH), %w[Types Default]).map do |node|
          Goldendocx::ContentTypes::Default.new(node[:Extension], node[:ContentType])
        end
      end

      def read_overrides(docx_file)
        @overrides = Goldendocx.xml_serializer.parse(docx_file.read(XML_PATH), %w[Types Override]).map do |node|
          Goldendocx::ContentTypes::Override.new(node[:PartName], node[:ContentType])
        end
      end

      def add_default(extension, content_type)
        new_default = Goldendocx::ContentTypes::Default.new(extension, content_type)
        defaults << new_default if defaults.none?(new_default)
      end

      def add_override(part_name, content_type)
        new_override = Goldendocx::ContentTypes::Override.new(part_name, content_type)
        overrides << new_override if overrides.none?(new_override)
      end

      def to_document_xml
        super do |xml|
          defaults.each { |default| xml << default }
          overrides.each { |override| xml << override }
        end
      end
    end
  end
end
