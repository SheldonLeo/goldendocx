# frozen_string_literal: true

module Goldendocx
  module Components
    class ColumnChart < Chart
      def initialize(chart_id, relationship_id, **attributes)
        super(chart_id, relationship_id, **attributes)

        build_chart.plot_area.build_column_chart
      end

      def the_chart
        chart.plot_area.column_chart
      end
    end
  end
end
