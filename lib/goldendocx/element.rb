# frozen_string_literal: true

require 'goldendocx/has_attributes'
require 'goldendocx/has_children'

module Goldendocx
  module Element
    extend ActiveSupport::Concern
    include Goldendocx::HasAttributes
    include Goldendocx::HasChildren

    class_methods do
      def tag(*args)
        @tag = args.first if args.any?
        @tag
      end

      def namespace(*args)
        @namespace = args.first if args.any?
        @namespace
      end

      def root_tag
        @root_tag ||= [namespace, tag].compact.join(':')
      end

      def read_from(xml_node, multiple: false)
        nodes = Goldendocx.xml_serializer.search(xml_node, [root_tag])
        nodes.each { |n| xml_node.unparsed_children.delete(n) }

        instances = nodes.map { |node| generate_instance(node) }

        multiple ? Array(instances) : instances.first
      end

      private

      def generate_instance(node)
        new.tap do |new_instance|
          new_instance.read_attributes(node)
          new_instance.read_children(node)
          new_instance.unparsed_children.concat node.unparsed_children.to_a
        end
      end
    end

    def tag
      self.class.concerning_ancestors.find { |ancestor| ancestor.tag.present? }&.tag
    end

    def namespace
      self.class.concerning_ancestors.find { |ancestor| ancestor.namespace.present? }&.namespace
    end

    def root_tag
      @root_tag ||= [namespace, tag].compact.join(':')
    end

    def to_element(**context, &block)
      Goldendocx.xml_serializer.build_element(root_tag, **context) { |xml| build_element(xml, &block) }
    end

    def to_xml(&block)
      Goldendocx.xml_serializer.build_xml(root_tag) { |xml| build_element(xml, &block) }
    end

    def build_element(xml)
      attributes.each { |name, value| xml[name] = value }
      unparsed_attributes.each { |name, value| xml[name] = value }

      children.each { |child| xml << child }
      unparsed_children.each { |child| xml << child }

      yield(xml) if block_given?
    end
  end
end
