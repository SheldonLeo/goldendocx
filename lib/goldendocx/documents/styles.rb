# frozen_string_literal: true

module Goldendocx
  module Documents
    class Styles
      include Goldendocx::Document

      XML_PATH = 'word/styles.xml'

      tag :styles
      namespace :w
      concern_namespaces :mc, :r, :w, :w14, :w15
      ignore_namespaces :w14, :w15

      attr_reader :styles, :doc_defaults, :latent_styles

      def initialize
        @styles = []
      end

      def size
        styles.size
      end

      def read_from(docx_file)
        @styles = Goldendocx.xml_serializer.parse(docx_file.read(XML_PATH), %w[w:styles w:style]).map do |node|
          Goldendocx::Documents::Style.new(node)
        end
        @doc_defaults = Goldendocx.xml_serializer.parse(docx_file.read(XML_PATH), %w[w:styles w:docDefaults]).map do |node|
          Goldendocx::Documents::UnparsedStyle.new(node)
        end
        @latent_styles = Goldendocx.xml_serializer.parse(docx_file.read(XML_PATH), %w[w:styles w:latentStyles]).map do |node|
          Goldendocx::Documents::UnparsedStyle.new(node)
        end
      end

      def to_document_xml
        super do |xml|
          @doc_defaults&.each { |element| xml << element }
          @latent_styles&.each { |element| xml << element }
          styles.each { |style| xml << style }
        end
      end

      def write_to(zos)
        zos.put_next_entry XML_PATH
        zos.write to_document_xml
      end

      def find_text_style(style_name)
        return if style_name.nil?

        styles.find { |s| s.type == 'paragraph' && s.name == style_name }
      end

      def find_table_style(style_name)
        return if style_name.nil?

        styles.find { |s| s.type == 'table' && s.name == style_name }
      end

      # FIXME: Not a good implementation for Nokogiri compatibility
      def add_style(fragment)
        style_id = (@styles.size + 1).to_s
        style = Goldendocx.xml_serializer.parse(fragment)
        style['w:styleId'] = style_id if style['w:styleId'].nil? || style['w:styleId'].empty?
        @styles << Goldendocx::Documents::Style.new(style)
        style_id
      end
    end
  end
end
