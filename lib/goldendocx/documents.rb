# frozen_string_literal: true

module Goldendocx
  module Documents
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'documents', '*.rb').to_s).each do |file|
  require file
end
