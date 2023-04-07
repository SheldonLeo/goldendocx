# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'properties', '*.rb').to_s).each do |file|
  require file
end
