# frozen_string_literal: true

module Goldendocx
  module ContentTypes
    class Default
      include Goldendocx::Element

      tag :Default

      attribute :extension, alias_name: :Extension
      attribute :content_type, alias_name: :ContentType

      def ==(other)
        extension == other.extension && content_type == other.content_type
      end
    end
  end
end
