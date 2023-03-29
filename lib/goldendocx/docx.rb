# frozen_string_literal: true

require 'goldendocx/models'
require 'goldendocx/components'
require 'goldendocx/documents'
require 'goldendocx/parts'

module Goldendocx
  class Docx
    include Goldendocx::HasAssociations

    attr_reader :unstructured_entries, :documents, :content_types

    RELATIONSHIPS_XML_PATH = '_rels/.rels'
    STRUCTURED_ENTRIES = [
      RELATIONSHIPS_XML_PATH,

      Goldendocx::Parts::ContentTypes::XML_PATH,

      Goldendocx::Parts::Documents::RELATIONSHIPS_XML_PATH,
      Goldendocx::Documents::Body::XML_PATH,
      Goldendocx::Documents::Styles::XML_PATH
    ].freeze

    associate :relationships, class_name: 'Goldendocx::Models::Relationships', path: RELATIONSHIPS_XML_PATH

    def initialize(file_path)
      docx_file = Zip::File.new(file_path)
      associations.each_key do |association|
        send(association).read_from(docx_file)
      end
      @documents = Goldendocx::Parts::Documents.read_from(docx_file)
      @content_types = Goldendocx::Parts::ContentTypes.read_from(docx_file)
      @unstructured_entries = docx_file.entries.filter_map do |entry|
        UnStructuredEntry.new(entry) unless STRUCTURED_ENTRIES.include?(entry.name)
      end
    end

    def write_to(new_path)
      File.binwrite(new_path, to_stream.string)
    end

    def create_text(text, options = {})
      documents.create_text(text, options)
    end

    def create_table(options = {})
      documents.create_table(options)
    end

    def create_image(image_data, options = {})
      ensure_image_content_type!(image_data)
      documents.create_image(image_data, options)
    end

    def create_embed_image(image_data, options = {})
      ensure_image_content_type!(image_data)
      documents.create_embed_image(image_data, options)
    end

    def add_style(style_path)
      documents.add_style(style_path)
    end

    def create_chart(chart_type, width: nil, height: nil)
      chart = documents.create_chart(
        chart_type, width || Charts::DEFAULT_WIDTH, height || Charts::DEFAULT_HEIGHT
      )
      ensure_chart_content_type!(chart)
      chart
    end

    private

    def ensure_image_content_type!(_image_data)
      extension = 'png'
      content_type = 'image/png'
      content_types.add_default(extension, content_type)
    end

    def ensure_chart_content_type!(chart)
      content_types.add_override(
        format(Charts::PART_NAME_PATTERN, id: chart.id), Charts::CONTENT_TYPE
      )
    end

    def to_stream
      Zip::OutputStream.write_buffer do |zos|
        associations.each_key do |association|
          send(association).write_to(zos)
        end

        zos.put_next_entry Goldendocx::Parts::ContentTypes::XML_PATH
        zos.write content_types.to_document_xml

        zos.put_next_entry Goldendocx::Parts::Documents::XML_PATH
        documents.write_stream(zos)

        @unstructured_entries.each { |unstructured_entry| unstructured_entry.write_to(zos) }
      end
    end

    # TODO: Remove this after all structured
    class UnStructuredEntry
      attr_reader :entry

      def initialize(entry)
        @entry = entry
      end

      def write_to(zos)
        zos.put_next_entry entry.name
        return if entry.directory?

        zos.write entry.get_input_stream.read
      end
    end
  end
end
