# frozen_string_literal: true

module Goldendocx
  module Documents
    class Body
      include Goldendocx::Element

      XML_PATH = 'word/document.xml'

      attr_reader :components, :charts

      namespace :w
      tag :body

      # TODO: Try to distinguish these paragraphs
      embeds_many :texts, class_name: 'Goldendocx::Components::Text'
      embeds_many :images, class_name: 'Goldendocx::Components::Image'

      embeds_many :tables, class_name: 'Goldendocx::Components::Table'

      embeds_one :section_property, class_name: 'Goldendocx::Documents::Properties::SectionProperty', auto_build: true

      class << self
        def read_from(xml_node)
          document = super(xml_node)

          component_tags = %w[w:p w:tbl]
          xml_node.children.map do |node|
            document.components << node if component_tags.include?(node.tag_name)
          end

          document
        end
      end

      def initialize
        @components = []
        @charts = []
      end

      # FIXME: Override for children not in correctly order
      def to_element(**_context)
        Goldendocx.xml_serializer.build_element(tag_name) do |xml|
          components.each { |component| xml << component }
          xml << section_property if section_property

          yield(xml) if block_given?
        end
      end

      def create_text(text, options = {})
        text = build_text(text: text, **options.slice(:align, :color, :bold))

        components << text

        text
      end

      def create_table(options = {})
        table = build_table
        table.width = options[:width] if options[:width]

        components << table

        table
      end

      def create_image(relationship_id, options)
        image = build_image(relationship_id: relationship_id, width: options[:width], height: options[:height])

        components << image

        image
      end

      def create_embed_image(relationship_id, options)
        Goldendocx::Components::Image.new(relationship_id: relationship_id, width: options[:width], height: options[:height])
      end

      def ensure_chart_type(chart_type)
        chart_class = "::Goldendocx::Components::#{chart_type.capitalize}Chart"
        raise Goldendocx::Charts::InvalidChartType unless Kernel.const_defined?(chart_class)

        Kernel.const_get(chart_class)
      end

      def create_chart(chart_type, chart_id, relationship_id, options)
        chart_class = ensure_chart_type(chart_type)

        chart = chart_class.new(chart_id, relationship_id, options)

        charts << chart
        components << chart

        chart
      end
    end
  end
end
