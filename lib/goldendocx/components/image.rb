# frozen_string_literal: true

require 'goldendocx/images'

module Goldendocx
  module Components
    class Image
      include Goldendocx::Element

      namespace :w
      tag :p

      embeds_one :property, class_name: 'Goldendocx::Components::Properties::Property', auto_build: true
      embeds_many :runs, class_name: 'Goldendocx::Components::Properties::Run'

      attr_reader :type, :container, :relationship_id, :width, :height

      def initialize(type: :shape, **attributes)
        @type = type
        @container = build_run

        case type
        when :picture
          inline_drawing = @container.build_drawing.build_inline
          inline_drawing.build_non_visual_property
          inline_drawing.build_extents
          inline_drawing.build_graphic.build_data.build_picture
        else
          @container.build_shape
        end

        attributes.each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end

      def relationship_id=(relationship_id)
        return unless relationship_id

        @relationship_id = relationship_id
        case type
        when :picture
          container.drawing.inline.non_visual_property.relationship_id = relationship_id
          container.drawing.inline.graphic.data.picture.relationship_id = relationship_id
        else
          container.shape.relationship_id = relationship_id
        end
      end

      def width=(width)
        return unless width

        @width = width
        case type
        when :picture
          container.drawing.inline.extents.width = width
          container.drawing.inline.graphic.data.picture.width = width
        else
          container.shape.width = width
        end
      end

      def height=(height)
        return unless height

        @height = height
        case type
        when :picture
          container.drawing.inline.extents.height = height
          container.drawing.inline.graphic.data.picture.height = height
        else
          container.shape.height = height
        end
      end
    end
  end
end
