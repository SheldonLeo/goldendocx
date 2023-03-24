# frozen_string_literal: true

module Goldendocx
  module Documents
    class Style
      attr_reader :node, :id, :type, :name

      def initialize(node)
        @node = node
        @id = node['w:styleId']
        @type = node['w:type']
        @name = node.public_send(:'w:name')['w:val']
        @default = node['w:default']
      end

      def to_element
        @node
      end
    end
  end
end
