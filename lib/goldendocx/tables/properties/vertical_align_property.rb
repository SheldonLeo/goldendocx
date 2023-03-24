# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class VerticalAlignProperty
        include Goldendocx::Element

        namespace :w
        tag :vAlign

        attribute :align, alias_name: :val, namespace: :w, default: :center
      end
    end
  end
end
