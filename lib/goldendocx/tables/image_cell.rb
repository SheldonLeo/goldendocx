# frozen_string_literal: true

module Goldendocx
  module Tables
    class ImageCell < Cell
      embeds_one :image, class_name: 'Goldendocx::Components::Image'

      def image=(image)
        build_image(
          relationship_id: image.relationship_id,
          width: image.width,
          height: image.height
        )
      end

      def content=(content)
        return unless content

        image.build_run.build_text.value = content
      end
    end
  end
end
