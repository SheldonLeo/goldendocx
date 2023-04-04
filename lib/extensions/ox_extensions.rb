# frozen_string_literal: true

require 'ox'

module Ox
  class Element
    def <<(node)
      # FIXME: Add this line to transform element implicitly
      node = node.public_send(:to_element) if node.respond_to?(:to_element)

      raise 'argument to << must be a String or Ox::Node.' unless node.is_a?(String) || node.is_a?(Node)

      @nodes = [] if !instance_variable_defined?(:@nodes) || @nodes.nil?
      @nodes << node
      self
    end

    def extract_contents
      contents = nodes.map(&:to_s)
      remove_children(*nodes)
      contents
    end

    alias children nodes
    alias tag_name name

    def unparsed_children
      @unparsed_children ||= children.dup
    end

    def attributes_hash
      attributes.with_indifferent_access.reject { |k, _| k.to_s.start_with?('xmlns') || k.to_s == 'mc:Ignorable' }
    end
  end
end
