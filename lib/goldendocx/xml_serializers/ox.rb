# frozen_string_literal: true

require 'ox'
require 'extensions/ox_extensions'

module Goldendocx
  module XmlSerializers
    class Ox
      class << self
        def parse(xml, paths = [])
          xml = ::Ox.parse(xml)
          xml = ::Ox::Document.new.tap { |document| document << xml } unless xml.is_a?(::Ox::Document)
          search(xml, paths)
        end

        def search(node, paths)
          return node if paths.blank?

          node.locate(paths.join('/'))
        end

        def build_xml(tag, &block)
          xml = build_element(tag, &block)
          ::Ox.dump(xml, indent: -1, with_xml: true, encoding: 'UTF-8')
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
