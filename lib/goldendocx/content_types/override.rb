# frozen_string_literal: true

module Goldendocx
  module ContentTypes
    class Override
      include Goldendocx::Element

      tag :Override
      attribute :part_name, alias_name: :PartName, readonly: true
      attribute :content_type, alias_name: :ContentType, readonly: true

      def initialize(part_name, content_type)
        @part_name = part_name
        @content_type = content_type
      end

      def ==(other)
        part_name == other.part_name && content_type == other.content_type
      end
    end
  end
end
