# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class RowHeightProperty
        include Goldendocx::Element

        namespace :w
        tag :trHeight

        attribute :height, alias_name: :val, namespace: :w, default: Goldendocx::Tables::DEFAULT_CELL_DXA_HEIGHT
        attribute :rule, alias_name: :hRule, namespace: :w, default: :atLeast
      end
    end
  end
end
