# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class StretchProperty
        include Goldendocx::Element

        namespace :a
        tag :stretch

        embeds_one :fill_rectangle, class_name: 'Goldendocx::Images::Properties::FillRectangleProperty',
                                    auto_build: true
      end
    end
  end
end
