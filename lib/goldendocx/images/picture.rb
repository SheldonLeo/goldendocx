# frozen_string_literal: true

module Goldendocx
  module Images
    class Picture
      include Goldendocx::Element

      namespace :pic
      tag :pic

      embeds_one :non_visual_picture, class_name: 'Goldendocx::Images::Properties::NonVisualPictureProperty', auto_build: true
      embeds_one :drawing, class_name: 'Goldendocx::Images::Properties::DrawingProperty', auto_build: true
      embeds_one :picture_fill, class_name: 'Goldendocx::Images::Properties::PictureFillProperty', auto_build: true
      embeds_one :picture_shape, class_name: 'Goldendocx::Images::Properties::PictureShapeProperty', auto_build: true

      def initialize(**attributes)
        attributes.each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end

      def width=(width)
        picture_shape.transform.extents.width = width if width
      end

      def height=(height)
        picture_shape.transform.extents.height = height if height
      end

      def relationship_id=(relationship_id)
        return unless relationship_id

        non_visual_picture.non_visual_drawing.assign_attributes(
          relationship_id:,
          name: "#{relationship_id}.png"
        )
        picture_fill.blip.relationship_id = relationship_id
      end
    end
  end
end
