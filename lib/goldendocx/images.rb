# frozen_string_literal: true

module Goldendocx
  module Images
  end
end

require 'goldendocx/images/properties'

Dir.glob(File.join(File.dirname(__FILE__), 'images', '*.rb').to_s).sort.each do |file|
  require file
end
