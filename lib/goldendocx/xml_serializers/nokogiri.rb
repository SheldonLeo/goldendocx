# frozen_string_literal: true

require 'nokogiri'

module Goldendocx
  module XmlSerializers
    module Nokogiri
      class << self
        DEFAULT_BUILD_OPTIONS = ::Nokogiri::XML::Node::SaveOptions.new.tap do |options|
          options.default_xml
          options.no_declaration
        end

        def parse(xml, paths = [])
          xml = ::Nokogiri::XML(xml)
          search(xml, paths)
        end

        def search(node, paths = [])
          return node if paths.blank?

          node.xpath(paths.map { |path| path.include?(':') || path == '*' ? path : ['xmlns', path].join(':') }.join('/'))
        end

        def find(node, paths = [])
          search(node, paths).first
        end

        def build_xml(tag, &block)
          build_element(tag, &block).to_xml(indent: 0, save_with: DEFAULT_BUILD_OPTIONS).delete("\n")
        end

        def build_document_xml(tag, namespaces = [], ignore_namespaces = [], &block)
          build_document(tag, namespaces, ignore_namespaces, &block).to_xml(indent: 0).delete("\n")
        end

        def build_document(tag, namespaces = [], ignore_namespaces = [])
          ::Nokogiri::XML('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>').tap do |root|
            root << ::Nokogiri::XML::Node.new(tag, root).tap do |document|
              Goldendocx::NAMESPACES.slice(*namespaces).each do |key, namespace|
                document.add_namespace key.to_s, namespace
              end
              document['mc:Ignorable'] = ignore_namespaces.join(' ') unless ignore_namespaces.empty?

              yield(document) if block_given?
            end
          end
        end

        def build_element(tag, parent: nil)
          parent ||= ::Nokogiri::XML('<?xml version="1.0"')
          ::Nokogiri::XML::Node.new(tag, parent).tap do |element|
            yield(element) if block_given?
          end
        end
      end
    end
  end
end

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
    end
  end
end
