# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class RowProperty
        include Goldendocx::Element

        namespace :w
        tag :trPr

        embeds_one :height, class_name: 'Goldendocx::Tables::Properties::RowHeightProperty', auto_build: true
      end
    end
  end
end
