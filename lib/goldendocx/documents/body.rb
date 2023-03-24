# frozen_string_literal: true

module Goldendocx
  module Documents
    class Body
      include Goldendocx::Element

      XML_PATH = 'word/document.xml'

      attr_reader :components, :properties, :charts

      namespace :w
      tag :body

      embeds_many :texts, class_name: 'Goldendocx::Components::Text'
      embeds_many :images, class_name: 'Goldendocx::Components::Image'
      embeds_many :tables, class_name: 'Goldendocx::Components::Table'

      def initialize
        @components = []
        @charts = []
      end

      def read_from(docx_file)
        Goldendocx.xml_serializer.parse(docx_file.read(XML_PATH), %w[w:document w:body *]).map do |node|
          element = Goldendocx::Documents::Element.new(node)
          @components << element if element.component?
          @properties = element if element.properties?
        end
      end

      # FIXME: Override for children not in correctly order
      def to_element
        Goldendocx.xml_serializer.build_element(root_tag) do |xml|
          components.each { |component| xml << component }
          xml << properties if properties

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
