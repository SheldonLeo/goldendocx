# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class CrossAxisProperty
        include Goldendocx::Element

        namespace :c
        tag :crossAx

        attribute :axis_id, alias_name: :val
      end
    end
  end
end
