# frozen_string_literal: true

# TODO: Only support create new table for now.
# TODO: To parse a table from exist file for replacement someday
require 'goldendocx/tables'

module Goldendocx
  module Components
    class Table
      include Goldendocx::Element

      attr_reader :headers

      namespace :w
      tag :tbl

      embeds_one :property, class_name: 'Goldendocx::Tables::Properties::Property', auto_build: true
      embeds_one :grid_property, class_name: 'Goldendocx::Tables::Properties::GridProperty', auto_build: true

      embeds_one :header, class_name: 'Goldendocx::Tables::HeaderRow', auto_build: true
      embeds_many :rows, class_name: 'Goldendocx::Tables::Row'

      def width=(width)
        property.table_width.width = width if width
      end

      def style=(style)
        property.table_style.style_id = style if style
      end

      def add_header(title, width: nil)
        header.build_cell(content: title, width: width)
        grid_property.build_grid_column(width: width) if width
        header
      end

      def add_row(cells)
        row = build_row
        cells.each { |data| row.add_cell data }
        row
      end
    end
  end
end
