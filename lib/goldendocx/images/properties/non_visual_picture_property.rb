# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class NonVisualPictureProperty
        include Goldendocx::Element

        namespace :pic
        tag :nvPicPr

        embeds_one :non_visual_drawing, class_name: 'Goldendocx::Images::Properties::NonVisualDrawingProperty',
                                        auto_build: true
      end
    end
  end
end
