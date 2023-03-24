# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class SeriesCategoryProperty
        include Goldendocx::Element

        namespace :c
        tag :cat

        embeds_one :values, class_name: 'Goldendocx::Charts::Properties::StringListProperty', auto_build: true
      end
    end
  end
end
