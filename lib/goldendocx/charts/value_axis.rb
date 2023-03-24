# frozen_string_literal: true

module Goldendocx
  module Charts
    class ValueAxis
      include Goldendocx::Element

      namespace :c
      tag :valAx

      embeds_one :axis_id, class_name: 'Goldendocx::Charts::Properties::AxisProperty', auto_build: true
      embeds_one :cross_axis, class_name: 'Goldendocx::Charts::Properties::CrossAxisProperty', auto_build: true

      def initialize
        build_axis_id(axis_id: 2094739)
        build_cross_axis(axis_id: 9374902)
      end
    end
  end
end
