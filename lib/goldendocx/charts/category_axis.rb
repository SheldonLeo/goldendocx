# frozen_string_literal: true

module Goldendocx
  module Charts
    class CategoryAxis
      include Goldendocx::Element

      namespace :c
      tag :catAx

      embeds_one :axis_id, class_name: 'Goldendocx::Charts::Properties::AxisProperty', auto_build: true
      embeds_one :cross_axis, class_name: 'Goldendocx::Charts::Properties::CrossAxisProperty', auto_build: true

      def initialize
        build_axis_id(axis_id: 9374902)
        build_cross_axis(axis_id: 2094739)
      end
    end
  end
end
