# frozen_string_literal: true

module Goldendocx
  module Models
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb').to_s).each do |file|
  require file
end
