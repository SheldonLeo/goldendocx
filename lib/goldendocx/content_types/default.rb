# frozen_string_literal: true

module Goldendocx
  module ContentTypes
    class Default
      include Goldendocx::Element

      tag :Default
      attribute :extension, alias_name: :Extension, readonly: true
      attribute :content_type, alias_name: :ContentType, readonly: true

      def initialize(extension, content_type)
        @extension = extension
        @content_type = content_type
      end

      def ==(other)
        extension == other.extension && content_type == other.content_type
      end
    end
  end
end
