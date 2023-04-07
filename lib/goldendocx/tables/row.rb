# frozen_string_literal: true

module Goldendocx
  module Tables
    class Row
      include Goldendocx::Element

      namespace :w
      tag :tr

      embeds_one :row_property, class_name: 'Goldendocx::Tables::Properties::RowProperty', auto_build: true
      embeds_many :cells, class_name: 'Goldendocx::Tables::Cell'

      def height=(height)
        row_property.height.height = height if height
      end

      def add_cell(data)
        cell = case data
               when Goldendocx::Tables::Cell then data
               when Hash then Goldendocx::Tables::Cell.new(**data)
               else Goldendocx::Tables::Cell.new(content: data.to_s)
               end
        cells << cell
      end
    end
  end
end
