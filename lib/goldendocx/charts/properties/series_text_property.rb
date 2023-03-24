# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class SeriesTextProperty
        include Goldendocx::Element

        namespace :c
        tag :tx

        embeds_one :value, class_name: 'Goldendocx::Charts::Properties::TextValueProperty', auto_build: true
      end
    end
  end
end
