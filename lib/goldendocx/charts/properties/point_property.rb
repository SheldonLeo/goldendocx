# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class PointProperty
        include Goldendocx::Element

        namespace :c
        tag :pt

        attribute :index, alias_name: :idx

        embeds_one :value, class_name: 'Goldendocx::Charts::Properties::TextValueProperty'
      end
    end
  end
end
