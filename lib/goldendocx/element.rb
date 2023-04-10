# frozen_string_literal: true

require 'goldendocx/has_attributes'
require 'goldendocx/has_children'

module Goldendocx
  module Element
    extend ActiveSupport::Concern
    include Goldendocx::HasAttributes
    include Goldendocx::HasChildren

    module ClassMethods
      def tag(*args)
        @tag = args.first if args.any?
        @tag
      end

      def namespace(*args)
        @namespace = args.first if args.any?
        @namespace
      end

      def tag_name
        @tag_name ||= [namespace, tag].compact.join(':')
      end

      def parse(xml_string)
        root_node = Goldendocx.xml_serializer.parse(xml_string).root
        read_from(root_node)
      end

      def adapt?(xml_node)
        tag_name == xml_node.tag_name
      end

      def read_from(xml_node)
        return unless adapt?(xml_node)

        instance = new
        instance.read_attributes(xml_node)
        instance.read_children(xml_node)
        instance
      end

      def concerning_ancestors
        ancestors.filter { |ancestor| ancestor.include?(Goldendocx::Element) }
      end
    end

    def initialize(attributes = nil)
      attributes ||= {}
      assign_attributes(**attributes)
    end

    def tag
      self.class.concerning_ancestors.find { |ancestor| ancestor.tag.present? }&.tag
    end

    def namespace
      self.class.concerning_ancestors.find { |ancestor| ancestor.namespace.present? }&.namespace
    end

    def tag_name
      @tag_name ||= [namespace, tag].compact.join(':')
    end

    def to_element(**context, &)
      Goldendocx.xml_serializer.build_element(tag_name, **context) { |xml| build_element(xml, &) }
    end

    def to_xml(&)
      Goldendocx.xml_serializer.build_xml(tag_name) { |xml| build_element(xml, &) }
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
