# frozen_string_literal: true

module Goldendocx
  module Components
    # 1 : 0.618
    DEFAULT_WIDTH = Goldendocx::Units::EMU_PER_CENTIMETER * 15
    DEFAULT_HEIGHT = Goldendocx::Units::EMU_PER_CENTIMETER * 9.27
  end
end

require 'goldendocx/components/properties'
require 'goldendocx/components/chart'

Dir.glob(File.join(File.dirname(__FILE__), 'components', '*.rb').to_s).each do |file|
  require file
end
