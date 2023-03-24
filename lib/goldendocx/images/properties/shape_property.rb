# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class ShapeProperty
        include Goldendocx::Element

        # 1 : 0.618
        DEFAULT_SHAPE_WIDTH = 15 * Goldendocx::Units::EMU_PER_CENTIMETER
        DEFAULT_SHAPE_HEIGHT = 9.27 * Goldendocx::Units::EMU_PER_CENTIMETER

        attr_accessor :width, :height

        namespace :v
        tag :shape

        attribute :style, method: :formatted_style

        embeds_one :image_data, class_name: 'Goldendocx::Images::Properties::ImageDataProperty', auto_build: true

        def formatted_style
          height = ((self.height || DEFAULT_SHAPE_HEIGHT) / Goldendocx::Units::EMU_PER_CENTIMETER).round(2)
          width = ((self.width || DEFAULT_SHAPE_WIDTH) / Goldendocx::Units::EMU_PER_CENTIMETER).round(2)
          "height:#{height}cm;width:#{width}cm"
        end
      end
    end
  end
end
