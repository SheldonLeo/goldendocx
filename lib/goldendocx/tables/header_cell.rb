# frozen_string_literal: true

module Goldendocx
  module Tables
    class HeaderCell < Cell
      def initialize(**attributes)
        super
        property.build_shading(value: :clear, color: :auto, fill: DEFAULT_BACKGROUND_COLOR)
      end

      def width=(width, type: :dxa)
        property.width.assign_attributes(width: width, type: type)
      end
    end
  end
end
