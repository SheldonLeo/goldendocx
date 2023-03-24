# frozen_string_literal: true

module Goldendocx
  module Components
    class Paragraph
      include Goldendocx::Element

      namespace :w
      tag :p

      embeds_one :property, class_name: 'Goldendocx::Components::Properties::Property', auto_build: true
      embeds_many :runs, class_name: 'Goldendocx::Components::Properties::Run'

      def align=(align)
        property.align.align = align if align
      end

      def style=(style)
        property.style.style_id = style if style
      end
    end
  end
end
