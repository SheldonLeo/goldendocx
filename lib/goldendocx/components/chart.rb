# frozen_string_literal: true

require 'goldendocx/charts'

# It is weired because this will generate two parts of XMLs
module Goldendocx
  module Components
    class Chart
      include Goldendocx::Document

      namespace :c
      tag :chartSpace
      concern_namespaces :c, :a, :r, :mc, :c14

      embeds_one :rounded_corner, class_name: 'Goldendocx::Charts::Properties::RoundedCornerProperty', auto_build: false
      embeds_one :chart, class_name: 'Goldendocx::Charts::Properties::ChartProperty', auto_build: true

      attr_reader :id, :series

      def initialize(chart_id, relationship_id, **attributes)
        @id = chart_id
        @series = []

        @paragraph = Goldendocx::Components::Paragraph.new
        inline_drawing = @paragraph.build_run.build_drawing.build_inline
        inline_drawing.build_non_visual_property(relationship_id: relationship_id)
        inline_drawing.build_extents(width: attributes[:width], height: attributes[:height])
        inline_drawing.build_graphic.build_data.build_chart(relationship_id: relationship_id)
      end

      def add_series(name, categories, values)
        ser_id = series.size + 1
        the_chart.build_series(categories: categories, values: values, id: ser_id, name: name)
        ser = Goldendocx::Charts::Series.new(categories: categories, values: values, id: ser_id, name: name)
        series << ser
        ser
      end

      def to_xml
        @paragraph.to_xml
      end

      def write_to(zos)
        entry_name = format(Goldendocx::Charts::RELATIONSHIP_NAME_PATTERN, id: id)
        zos.put_next_entry "word/#{entry_name}"
        zos.write to_document_xml
      end
    end
  end
end
