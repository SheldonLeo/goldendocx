# frozen_string_literal: true

require 'ox'

module Goldendocx
  module XmlSerializers
    class Ox
      class << self
        def parse(xml, paths = [])
          xml = ::Ox.parse(xml)
          xml = xml.locate(paths.join('/')) unless paths.empty?
          xml
        end

        def build_xml(tag, &block)
          xml = build_element(tag, &block)
          ::Ox.dump(xml, indent: -1, with_xml: true)
        end

        def build_document_xml(tag, namespaces = [], ignore_namespaces = [], &block)
          xml = build_document(tag, namespaces, ignore_namespaces, &block)
          ::Ox.dump(xml, indent: -1, with_xml: true)
        end

        def build_document(tag, namespaces = [], ignore_namespaces = [])
          ::Ox::Document.new(encoding: 'UTF-8', version: '1.0', standalone: 'yes').tap do |root|
            root << ::Ox::Element.new(tag).tap do |document|
              Goldendocx::NAMESPACES.slice(*namespaces).each do |key, namespace|
                document["xmlns:#{key}"] = namespace
              end

              document['mc:Ignorable'] = ignore_namespaces.join(' ') unless ignore_namespaces.empty?

              yield(document) if block_given?
            end
          end
        end

        def build_element(tag)
          ::Ox::Element.new(tag).tap do |element|
            yield(element) if block_given?
          end
        end
      end
    end
  end
end

# FIXME: Temporarily here to provider syntactic sugar
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
  end
end
