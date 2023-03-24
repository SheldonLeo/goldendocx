# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class ExtentsProperty
        include Goldendocx::Element

        namespace :wp
        tag :extent

        attribute :width, alias_name: :cx, default: Goldendocx::Components::DEFAULT_WIDTH
        attribute :height, alias_name: :cy, default: Goldendocx::Components::DEFAULT_HEIGHT
      end
    end
  end
end
