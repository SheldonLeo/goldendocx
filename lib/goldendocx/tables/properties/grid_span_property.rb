# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class GridSpanProperty
        include Goldendocx::Element

        namespace :w
        tag :gridSpan

        attribute :span, alias_name: :val, namespace: :w
      end
    end
  end
end
