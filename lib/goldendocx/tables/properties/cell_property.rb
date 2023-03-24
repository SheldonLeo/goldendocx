# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class CellProperty
        include Goldendocx::Element

        namespace :w
        tag :tcPr

        embeds_one :width, class_name: 'Goldendocx::Tables::Properties::CellWidthProperty', auto_build: true
        embeds_one :vertical_align, class_name: 'Goldendocx::Tables::Properties::VerticalAlignProperty', auto_build: true
        embeds_one :grid_span, class_name: 'Goldendocx::Tables::Properties::GridSpanProperty', auto_build: true
        embeds_one :shading, class_name: 'Goldendocx::Tables::Properties::ShadingProperty', auto_build: true
      end
    end
  end
end
