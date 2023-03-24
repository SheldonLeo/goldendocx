# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class DirectionProperty
        include Goldendocx::Element

        namespace :c
        tag :barDir

        attribute :direction, alias_name: :val, default: :bar
      end
    end
  end
end
