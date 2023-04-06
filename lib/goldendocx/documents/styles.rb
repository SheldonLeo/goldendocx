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

      embeds_one :defaults, class_name: 'Goldendocx::Documents::Properties::DefaultStyleProperty', auto_build: true
      embeds_one :latentStyles, class_name: 'Goldendocx::Documents::LatentStyles'
      embeds_many :styles, class_name: 'Goldendocx::Documents::Style'

      def size
        styles.size
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
        style = Goldendocx::Documents::Style.parse(fragment)
        style.id = (styles.size + 1).to_s # Rearrange id to prevent duplicates
        styles << style
        style.id
      end
    end
  end
end
