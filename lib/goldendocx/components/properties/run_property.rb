# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class RunProperty
        include Goldendocx::Element

        namespace :w
        tag :rPr

        embeds_one :color, class_name: 'Goldendocx::Components::Properties::ColorProperty', auto_build: false
        embeds_one :bold, class_name: 'Goldendocx::Components::Properties::BoldProperty', auto_build: false
        embeds_one :language, class_name: 'Goldendocx::Components::Properties::LanguageProperty', auto_build: false
        embeds_one :font, class_name: 'Goldendocx::Components::Properties::FontProperty', auto_build: false
      end
    end
  end
end
