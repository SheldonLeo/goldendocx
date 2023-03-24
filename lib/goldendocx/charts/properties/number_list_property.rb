# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class NumberListProperty
        include Goldendocx::Element

        namespace :c
        tag :numLit

        embeds_one :count, class_name: 'Goldendocx::Charts::Properties::PointCountProperty', auto_build: true
        embeds_many :points, class_name: 'Goldendocx::Charts::Properties::PointProperty'
      end
    end
  end
end
