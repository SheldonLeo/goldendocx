# frozen_string_literal: true

module Goldendocx
  module Tables
    DEFAULT_TABLE_DXA_WIDTH = 8600
    DEFAULT_CELL_DXA_WIDTH = 600
    DEFAULT_CELL_DXA_HEIGHT = 600

    DEFAULT_BACKGROUND_COLOR = 'F5F5F5'
  end
end

require 'goldendocx/tables/properties'
require 'goldendocx/tables/row'
require 'goldendocx/tables/cell'

Dir.glob(File.join(File.dirname(__FILE__), 'tables', '*.rb').to_s).each do |file|
  require file
end
