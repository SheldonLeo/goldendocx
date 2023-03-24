# frozen_string_literal: true

module Goldendocx
  module Documents
    class Element
      def initialize(node)
        @node = node
      end

      def component?
        %w[w:p w:tbl].include?(@node.name)
      end

      def properties?
        @node.name == 'w:sectPr'
      end

      def to_element
        @node
      end
    end
  end
end
