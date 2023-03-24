# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class PlotAreaProperty
        include Goldendocx::Element

        namespace :c
        tag :plotArea

        embeds_one :layout, class_name: 'Goldendocx::Charts::Properties::LayoutProperty', auto_build: true
        embeds_one :category_axis, class_name: 'Goldendocx::Charts::CategoryAxis', auto_build: true
        embeds_one :value_axis, class_name: 'Goldendocx::Charts::ValueAxis', auto_build: true

        embeds_one :line_chart, class_name: 'Goldendocx::Charts::Properties::LineChartProperty', auto_build: false
        embeds_one :bar_chart, class_name: 'Goldendocx::Charts::Properties::BarChartProperty', auto_build: false
        embeds_one :column_chart, class_name: 'Goldendocx::Charts::Properties::ColumnChartProperty', auto_build: false
        embeds_one :doughnut_chart, class_name: 'Goldendocx::Charts::Properties::DoughnutChartProperty', auto_build: false
      end
    end
  end
end
