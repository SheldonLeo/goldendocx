# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class PointCountProperty
        include Goldendocx::Element

        namespace :c
        tag :ptCount

        attribute :count, alias_name: :val
      end
    end
  end
end
