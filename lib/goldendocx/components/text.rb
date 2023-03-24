# frozen_string_literal: true

module Goldendocx
  module Components
    class Text
      include Goldendocx::Element

      namespace :w
      tag :p

      embeds_one :property, class_name: 'Goldendocx::Components::Properties::Property', auto_build: true
      embeds_one :run, class_name: 'Goldendocx::Components::Properties::Run', auto_build: true

      def align=(align)
        property.align.align = align if align
      end

      def style=(style)
        property.style.style_id = style if style
      end

      def text=(text)
        run.build_text.value = text if text
      end

      def color=(color_hex)
        (run.property || run.build_property).build_color(hex: color_hex) if color_hex
      end

      def bold=(bold)
        (run.property || run.build_property).build_bold(enabled: bold) if bold
      end
    end
  end
end
