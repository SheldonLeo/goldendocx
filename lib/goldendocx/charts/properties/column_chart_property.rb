# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class ColumnChartProperty
        include Goldendocx::Element

        namespace :c
        tag :barChart

        embeds_one :direction, class_name: 'Goldendocx::Charts::Properties::DirectionProperty', auto_build: true
        embeds_one :grouping, class_name: 'Goldendocx::Charts::Properties::GroupingProperty', auto_build: true

        embeds_many :axes, class_name: 'Goldendocx::Charts::Properties::AxisProperty'
        embeds_many :series, class_name: 'Goldendocx::Charts::Series'

        def initialize
          build_direction(direction: :col)
          build_grouping(value: :clustered)

          build_axis(axis_id: 9374902)
          build_axis(axis_id: 2094739)
        end
      end
    end
  end
end
