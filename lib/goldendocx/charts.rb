# frozen_string_literal: true

module Goldendocx
  module Charts
    CONTENT_TYPE = 'application/vnd.openxmlformats-officedocument.drawingml.chart+xml'
    PART_NAME_PATTERN = '/word/charts/chart%<id>s.xml'

    RELATIONSHIP_TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/chart'
    RELATIONSHIP_NAME_PATTERN = 'charts/chart%<id>s.xml'

    DEFAULT_WIDTH = Goldendocx::Units::EMU_PER_CENTIMETER * 16
    DEFAULT_HEIGHT = Goldendocx::Units::EMU_PER_CENTIMETER * 10

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
