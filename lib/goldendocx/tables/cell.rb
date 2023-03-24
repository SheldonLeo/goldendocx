# frozen_string_literal: true

module Goldendocx
  module Tables
    class Cell
      include Goldendocx::Element

      namespace :w
      tag :tc

      embeds_one :property, class_name: 'Goldendocx::Tables::Properties::CellProperty', auto_build: true
      embeds_one :text, class_name: 'Goldendocx::Components::Text', auto_build: true

      def initialize(**attributes)
        attributes.each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end

      def content=(content)
        text.run.build_text.value = content.to_s if content
      end

      def align=(align)
        text.property.align.align = align if align
      end

      def span=(span)
        property.grid_span.span = span if span
      end
    end
  end
end
