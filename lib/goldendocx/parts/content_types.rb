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
      }.with_indifferent_access.freeze

      tag :Types
      attribute :xmlns, default: NAMESPACE, readonly: true

      embeds_many :defaults, class_name: 'Goldendocx::ContentTypes::Default', uniqueness: true
      embeds_many :overrides, class_name: 'Goldendocx::ContentTypes::Override', uniqueness: true

      def initialize
        REQUIRED_DEFAULTS.map do |extension, content_type|
          build_defaults(extension:, content_type:)
        end
      end

      def write_to(zos)
        zos.put_next_entry XML_PATH
        zos.write to_document_xml
      end

      def add_default(extension, content_type)
        return if defaults.any? { |default| extension == default.extension && content_type == default.content_type }

        build_defaults(extension:, content_type:)
      end

      def add_override(part_name, content_type)
        return if overrides.any? { |override| part_name == override.part_name && content_type == override.content_type }

        build_override(part_name:, content_type:)
      end
    end
  end
end
