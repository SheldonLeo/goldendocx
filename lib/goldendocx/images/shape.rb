# frozen_string_literal: true

module Goldendocx
  module Images
    class Shape
      include Goldendocx::Element

      namespace :w
      tag :pict

      embeds_one :property, class_name: 'Goldendocx::Images::Properties::ShapeProperty', auto_build: true

      def initialize(**attributes)
        attributes.each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end

      def width=(width)
        property.width = width if width
      end

      def height=(height)
        property.height = height if height
      end

      def relationship_id=(relationship_id)
        property.image_data.relationship_id = relationship_id if relationship_id
      end
    end
  end
end
