# frozen_string_literal: true

module Goldendocx
  module Charts
    CONTENT_TYPE = 'application/vnd.openxmlformats-officedocument.drawingml.chart+xml'
    PART_NAME_PATTERN = '/word/charts/chart%<id>s.xml'

    RELATIONSHIP_TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/chart'
    RELATIONSHIP_NAME_PATTERN = 'charts/chart%<id>s.xml'

    DEFAULT_WIDTH = 16 * Goldendocx::Units::EMU_PER_CENTIMETER
    DEFAULT_HEIGHT = 10 * Goldendocx::Units::EMU_PER_CENTIMETER

    class InvalidChartType < StandardError
      def initialize
        super('Invalid chart type, supported types are [ line, bar, column, doughnut ]')
      end
    end
  end
end

require 'goldendocx/charts/properties'

Dir.glob(File.join(File.dirname(__FILE__), 'charts', '*.rb').to_s).sort.each do |file|
  require file
end
