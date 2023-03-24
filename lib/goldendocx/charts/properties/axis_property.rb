# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class AxisProperty
        include Goldendocx::Element

        namespace :c
        tag :axId

        attribute :axis_id, alias_name: :val
      end
    end
  end
end
