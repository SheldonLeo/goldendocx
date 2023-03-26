# frozen_string_literal: true

module Goldendocx
  module Documents
    class UnparsedStyle
      attr_reader :node

      def initialize(node)
        @node = node
      end

      def to_element(**_context)
        @node
      end
    end
  end
end
