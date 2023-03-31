# frozen_string_literal: true

module Goldendocx
  module Documents
    class Styles
      include Goldendocx::Document

      XML_PATH = 'word/styles.xml'
      TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles'
      CONTENT_TYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml'

      tag :styles
      namespace :w
      concern_namespaces :mc, :r, :w, :w14, :w15
      ignore_namespaces :w14, :w15

      attr_reader :styles, :latent_styles

      embeds_one :defaults, class_name: 'Goldendocx::Documents::Properties::DefaultStyleProperty', auto_build: true

      class << self
        def read_from(xml_node, multiple: nil)
          new_instance = super(xml_node, multiple: multiple)

          styles = Goldendocx.xml_serializer.search(xml_node, %w[w:styles w:style]).map do |node|
            Goldendocx::Documents::Style.new(node)
          end
          new_instance.instance_variable_set(:@styles, styles)

          latent_styles = Goldendocx.xml_serializer.search(xml_node, %w[w:styles w:latentStyles]).map do |node|
            Goldendocx::Documents::UnparsedStyle.new(node)
          end
          new_instance.instance_variable_set(:@latent_styles, latent_styles)

          new_instance
        end
      end

      def initialize
        @styles = []
        @latent_styles = []
      end

      def size
        styles.size
      end

      def to_document_xml
        super do |xml|
          @latent_styles.each { |element| xml << element }
          styles.each { |style| xml << style }
        end
      end

      def write_to(zos, xml_path = XML_PATH)
        zos.put_next_entry xml_path
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

      def add_style(fragment)
        # FIXME: Not a good implementation for Nokogiri compatibility
        raise NotImplementedError unless Goldendocx.config.xml_serializer == :ox

        style_id = (@styles.size + 1).to_s
        style = Goldendocx.xml_serializer.parse(fragment)
        style['w:styleId'] = style_id if style['w:styleId'].nil? || style['w:styleId'].empty?
        @styles << Goldendocx::Documents::Style.new(style)
        style_id
      end
    end
  end
end
