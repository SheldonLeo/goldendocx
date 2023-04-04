# frozen_string_literal: true

module Goldendocx
  module Documents
    class Element
      def initialize(node)
        @node = node
      end

      def component?
        %w[w:p w:tbl].include?(@node.tag_name)
      end

      def properties?
        @node.tag_name == 'w:sectPr'
      end

      def to_element(**_context)
        @node
      end
    end
  end
end
