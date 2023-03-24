# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class Run
        include Goldendocx::Element

        namespace :w
        tag :r

        embeds_one :property, class_name: 'Goldendocx::Components::Properties::RunProperty', auto_build: false

        embeds_one :text, class_name: 'Goldendocx::Components::Properties::Textual', auto_build: false
        embeds_one :shape, class_name: 'Goldendocx::Images::Shape', auto_build: false
        embeds_one :drawing, class_name: 'Goldendocx::Components::Properties::Drawing', auto_build: false
      end
    end
  end
end
