# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class GroupingProperty
        include Goldendocx::Element

        namespace :c
        tag :grouping

        attribute :value, alias_name: :val, default: :standard
      end
    end
  end
end
