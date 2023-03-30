# frozen_string_literal: true

# Just to mark a element as a root document node
module Goldendocx
  module Document
    def self.included(base)
      base.extend(ClassMethods)
      base.include(Goldendocx::Element)
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

    def concerned_namespaces
      self.class.concerning_ancestors.flat_map(&:concerned_namespaces)
    end

    def ignorable_namespaces
      self.class.concerning_ancestors.flat_map(&:ignorable_namespaces)
    end

    def to_document_xml
      Goldendocx.xml_serializer.build_document_xml(root_tag, concerned_namespaces, ignorable_namespaces) do |xml|
        attributes.each { |name, value| xml[name] = value }

        yield(xml) if block_given?

        children.each { |child| xml << child }
      end
    end
  end
end
