# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class TextValueProperty
        include Goldendocx::Element

        namespace :c
        tag :v

        embeds_one :value, class_name: 'String'
      end
    end
  end
end
