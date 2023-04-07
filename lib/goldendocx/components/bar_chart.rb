# frozen_string_literal: true

module Goldendocx
  module Components
    class BarChart < Chart
      def initialize(chart_id, relationship_id, attributes = {})
        super(chart_id, relationship_id, attributes)

        build_chart.plot_area.build_bar_chart
      end

      def the_chart
        chart.plot_area.bar_chart
      end
    end
  end
end
