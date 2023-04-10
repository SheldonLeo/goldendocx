# frozen_string_literal: true

require 'extensions/nokogiri_extensions'

module Goldendocx
  module XmlSerializers
    module Nokogiri
      class << self
        DEFAULT_BUILD_OPTIONS = ::Nokogiri::XML::Node::SaveOptions.new.tap do |options|
          options.default_xml
          options.no_declaration
        end

        # TODO: Nokogiri namespace is soooo strict....
        # TODO: To read nokogiri source codes and try to understand how it works
        def parse(xml)
          document = ::Nokogiri::XML(xml)

          missing_namespaces = document.errors.filter_map do |error|
            error.str1 if error.message.match?('Namespace.*not defined')
          end.uniq.compact
          return document if missing_namespaces.blank?

          wrap_document(document, missing_namespaces)
        end

        def search(node, paths)
          return node if paths.blank?

          search_paths = paths.map { |path| path.include?(':') || path == '*' ? path : ['xmlns', path].join(':') }
          namespaces = node.namespaces.merge(node.document.namespaces)
          node.xpath(search_paths.join('/'), namespaces)
        end

        def build_xml(tag, &)
          CGI.unescapeHTML build_element(tag, &).to_xml(indent: 0, save_with: DEFAULT_BUILD_OPTIONS).delete("\n")
        end

        def build_document_xml(tag, namespaces = [], ignore_namespaces = [], &)
          CGI.unescapeHTML build_document(tag, namespaces, ignore_namespaces, &).to_xml(indent: 0).delete("\n")
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
          ::Nokogiri::XML::Node.new(tag.to_s, parent).tap do |element|
            yield(element) if block_given?
          end
        end

        private

        def wrap_document(document, missing_namespaces)
          missing_namespaces.each do |ns|
            document.root.add_namespace ns, (Goldendocx::NAMESPACES[ns.to_sym] || "#{ns}:goldendocx")
          end
          ::Nokogiri::XML(document.to_xml(indent: 0).delete("\n"))
        end
      end
    end
  end
end
