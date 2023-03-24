# frozen_string_literal: true

module Goldendocx
  module Tables
    class HeaderRow < Row
      include Goldendocx::Element

      namespace :w
      tag :tr

      embeds_one :header_row, class_name: 'Goldendocx::Tables::Properties::HeaderRowProperty', auto_build: true
    end
  end
end
