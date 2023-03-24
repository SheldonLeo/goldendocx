# frozen_string_literal: true

module Goldendocx
  module Parts
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'parts', '*.rb').to_s).sort.each do |file|
  require file
end
