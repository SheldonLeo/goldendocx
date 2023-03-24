# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class HeaderRowProperty
        include Goldendocx::Element

        namespace :w
        tag :tblHeader
      end
    end
  end
end
