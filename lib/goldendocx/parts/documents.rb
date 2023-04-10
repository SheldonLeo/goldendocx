# frozen_string_literal: true

# Parts hold entries at directory word/
module Goldendocx
  module Parts
    class Documents
      include Goldendocx::HasAssociations

      XML_PATH = 'word/'
      RELATIONSHIPS_XML_PATH = 'word/_rels/document.xml.rels'

      attr_reader :document, # document.xml
                  :charts, # charts/
                  :medias # New Medias to media/

      attr_accessor :media_amount # Entries amount in directory media/ for generating relationship id

      relationships_at RELATIONSHIPS_XML_PATH
      associate :styles, class_name: 'Goldendocx::Documents::Styles'
      associate :settings, class_name: 'Goldendocx::Documents::Settings'
      associate :document, class_name: 'Goldendocx::Documents::Document', isolate: true

      class << self
        def read_from(docx_file)
          parts = Goldendocx::Parts::Documents.new
          parts.read_relationships(docx_file)
          parts.read_associations(docx_file)
          parts.media_amount = docx_file.entries.count { |entry| entry.name.start_with?('word/media/') }
          parts
        end
      end

      def initialize
        associations.each do |association, options|
          association_class = options.class_name.constantize
          instance_variable_set("@#{association}", association_class.new)
          add_relationship association_class::TYPE, association_class::XML_PATH.gsub(XML_PATH, '') unless options.isolate
        end

        @medias = []
        @media_amount = 0
      end

      def write_stream(zos)
        write_relationships(zos)

        associations.each_key do |association|
          send(association).write_to(zos)
        end

        document.write_to(zos)
        medias.each { |media| media.write_to(zos) }
        document.body.charts.each { |chart| chart.write_to(zos) }
      end

      def create_text(text, options = {})
        paragraph = document.body.create_text(text, options)

        style = styles.find_text_style(options[:style])
        paragraph.style = style.id if style

        paragraph
      end

      def create_table(options = {})
        table = document.body.create_table(options)

        style = styles.find_table_style(options[:style])
        table.style = style.id if style

        table
      end

      def create_image(image_data, type, options = {})
        image_media = add_image_media(image_data, type, options)
        relationship_id = add_relationship(Goldendocx::Parts::Media::TYPE, image_media.target)

        document.body.create_image(relationship_id, options)
      end

      def create_embed_image(image_data, type, options = {})
        image_media = add_image_media(image_data, type, options)
        relationship_id = add_relationship(Goldendocx::Parts::Media::TYPE, image_media.target)

        document.body.create_embed_image(relationship_id, options)
      end

      def add_image_media(image_data, type, _options = {})
        # Add to media
        @media_amount += 1
        image_name = "image#{media_amount}.#{type}"
        Goldendocx::Parts::Media.new(image_name, image_data).tap do |media|
          medias << media
        end
      end

      def create_chart(chart_type, width, height)
        document.body.ensure_chart_type(chart_type)

        chart_id = document.body.charts.size + 1

        relationship_id = add_relationship(
          Goldendocx::Charts::RELATIONSHIP_TYPE,
          format(Goldendocx::Charts::RELATIONSHIP_NAME_PATTERN, id: chart_id)
        )

        document.body.create_chart(chart_type, chart_id, relationship_id, width:, height:)
      end

      def add_style(fragment)
        styles.add_style(fragment)
      end
    end
  end
end
