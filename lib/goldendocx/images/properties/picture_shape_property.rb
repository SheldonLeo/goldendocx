# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class PictureShapeProperty
        include Goldendocx::Element

        namespace :pic
        tag :spPr

        embeds_one :transform, class_name: 'Goldendocx::Images::Properties::TransformProperty', auto_build: true
      end
    end
  end
end
