# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class PaddingProperty
        include Goldendocx::Element

        namespace :wp
        tag :effectExtent

        attribute :left, alias_name: :l, default: 0
        attribute :right, alias_name: :r, default: 0
        attribute :top, alias_name: :t, default: 0
        attribute :bottom, alias_name: :b, default: 0
      end
    end
  end
end
