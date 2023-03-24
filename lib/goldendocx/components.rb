# frozen_string_literal: true

module Goldendocx
  module Components
    # 1 : 0.618
    DEFAULT_WIDTH = 15 * Goldendocx::Units::EMU_PER_CENTIMETER
    DEFAULT_HEIGHT = 9.27 * Goldendocx::Units::EMU_PER_CENTIMETER
  end
end

require 'goldendocx/components/properties'
require 'goldendocx/components/chart'

Dir.glob(File.join(File.dirname(__FILE__), 'components', '*.rb').to_s).sort.each do |file|
  require file
end
