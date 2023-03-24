# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class HoleProperty
        include Goldendocx::Element

        namespace :c
        tag :holeSize

        attribute :size, alias_name: :val, default: 60
      end
    end
  end
end
