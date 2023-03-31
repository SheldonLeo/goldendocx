# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class RunDefaultStyleProperty
        include Goldendocx::Element

        namespace :w
        tag :rPrDefault

        embeds_one :property, class_name: 'Goldendocx::Components::Properties::RunProperty'

        def initialize
          build_property
          property.build_language
          property.build_font
        end
      end
    end
  end
end
