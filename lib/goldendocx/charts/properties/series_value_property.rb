# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class SeriesValueProperty
        include Goldendocx::Element

        namespace :c
        tag :val

        embeds_one :values, class_name: 'Goldendocx::Charts::Properties::NumberListProperty', auto_build: true
      end
    end
  end
end
