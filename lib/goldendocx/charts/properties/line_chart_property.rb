# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class LineChartProperty
        include Goldendocx::Element

        namespace :c
        tag :lineChart

        embeds_one :grouping, class_name: 'Goldendocx::Charts::Properties::GroupingProperty', auto_build: true

        embeds_many :axes, class_name: 'Goldendocx::Charts::Properties::AxisProperty'
        embeds_many :series, class_name: 'Goldendocx::Charts::Series'
      end
    end
  end
end
