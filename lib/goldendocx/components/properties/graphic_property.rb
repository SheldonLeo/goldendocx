# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class GraphicProperty
        include Goldendocx::Element

        namespace :a
        tag :graphic

        embeds_one :data, class_name: 'Goldendocx::Components::Properties::GraphicDataProperty', auto_build: true
      end
    end
  end
end
