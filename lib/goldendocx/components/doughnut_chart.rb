# frozen_string_literal: true

module Goldendocx
  module Components
    class DoughnutChart < Chart
      def initialize(chart_id, relationship_id, **attributes)
        super(chart_id, relationship_id, **attributes)

        build_chart.plot_area.build_doughnut_chart
      end

      def the_chart
        chart.plot_area.doughnut_chart
      end
    end
  end
end
