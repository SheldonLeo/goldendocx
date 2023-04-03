# frozen_string_literal: true

# FIXME: Temporarily here to provider syntactic sugar
module Nokogiri
  module XML
    class Node
      def <<(node_or_tags)
        # FIXME: Add this line to transform element implicitly
        node_or_tags = node_or_tags.public_send(:to_element, parent: self) if node_or_tags.respond_to?(:to_element)

        add_child(node_or_tags)
        self
      end

      def extract_contents
        children.each(&:remove).map(&:content).map(&:to_s)
      end

      def unparsed_children
        @unparsed_children ||= children.dup
      end

      def attributes_hash
        attribute_nodes.to_h do |node|
          namespaced = [node.namespace&.prefix, node.node_name].compact.join(':')
          [namespaced, node.value]
        end
      end
    end
  end
end
