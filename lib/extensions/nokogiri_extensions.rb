# frozen_string_literal: true

require 'nokogiri'

# FIXME: Temporarily here to provider syntactic sugar
module Nokogiri
  module XML
    class Document
      def tag_name
        root.tag_name
      end
    end

    class Node
      def <<(node_or_tags)
        # FIXME: Add this line to transform element implicitly
        node_or_tags = node_or_tags.public_send(:to_element, parent: self) if node_or_tags.respond_to?(:to_element)

        add_child(node_or_tags)
        self
      end

      def adapt?(klass)
        adaptable_classes = [String, Integer, Time]
        is_a?(Nokogiri::XML::Text) && adaptable_classes.include?(klass)
      end

      def tag_name
        [namespace&.prefix, name].compact.join(':')
      end

      def unparsed_children
        @unparsed_children ||= children.dup
      end

      def attributes_hash
        attribute_nodes.reject { |node| node.tag_name == 'mc:Ignorable' }.to_h { |node| [node.tag_name, node.value] }
      end
    end
  end
end
