# frozen_string_literal: true

module Goldendocx
  module Components
    class LineChart < Chart
      def initialize(chart_id, relationship_id, attributes = {})
        super(chart_id, relationship_id, attributes)

        build_chart.plot_area.build_line_chart
      end

      def the_chart
        chart.plot_area.line_chart
      end
    end
  end
end
