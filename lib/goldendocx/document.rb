# frozen_string_literal: true

# Just to mark a element as a root document node
module Goldendocx
  module Document
    extend ActiveSupport::Concern
    include Goldendocx::Element

    included do
      class_attribute :concerned_namespaces, default: []
      class_attribute :ignorable_namespaces, default: []
    end

    class_methods do
      def concern_namespaces(*namespaces)
        namespaces.each do |namespace|
          concerned_namespaces << namespace unless concerned_namespaces.include?(namespace)
        end
      end

      def ignore_namespaces(*namespaces)
        namespaces.each do |namespace|
          ignorable_namespaces << namespace.to_sym unless ignorable_namespaces.include?(namespace)
        end
      end
    end

    def to_document_xml(&)
      Goldendocx.xml_serializer.build_document_xml(tag_name, concerned_namespaces, ignorable_namespaces) { |xml| build_element(xml, &) }
    end
  end
end
