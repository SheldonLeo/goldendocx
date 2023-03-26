# frozen_string_literal: true

# Just to mark a element as a root document node
module Goldendocx
  module Document
    def self.included(base)
      base.include(Goldendocx::Element)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def concern_namespaces(*namespaces)
        namespaces.each do |namespace|
          concerned_namespaces << namespace unless concerned_namespaces.include?(namespace)
        end
      end

      def concerned_namespaces
        @concerned_namespaces ||= []
      end

      def ignore_namespaces(*namespaces)
        namespaces.each do |namespace|
          ignorable_namespaces << namespace.to_sym unless ignorable_namespaces.include?(namespace)
        end
      end

      def ignorable_namespaces
        @ignorable_namespaces ||= []
      end
    end

    def to_document_xml
      Goldendocx.xml_serializer.build_document_xml(
        root_tag,
        self.class.concerned_namespaces,
        self.class.ignorable_namespaces
      ) do |xml|
        attributes.each { |name, value| xml[name] = value }

        yield(xml) if block_given?

        children.each { |child| xml << child }
      end
    end
  end
end