# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class RoundedCornerProperty
        include Goldendocx::Element

        namespace :c
        tag :roundedCorner

        attribute :enabled, alias_name: :val, default: true
      end
    end
  end
end
