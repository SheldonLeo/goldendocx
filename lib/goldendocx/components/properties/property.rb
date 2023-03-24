# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class Property
        include Goldendocx::Element

        namespace :w
        tag :pPr

        embeds_one :style, class_name: 'Goldendocx::Components::Properties::StyleProperty', auto_build: true
        embeds_one :align, class_name: 'Goldendocx::Components::Properties::AlignProperty', auto_build: true
      end
    end
  end
end
