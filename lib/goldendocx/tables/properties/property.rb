# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class Property
        include Goldendocx::Element

        namespace :w
        tag :tblPr

        embeds_one :table_style, class_name: 'Goldendocx::Tables::Properties::StyleProperty', auto_build: true
        embeds_one :table_width, class_name: 'Goldendocx::Tables::Properties::WidthProperty', auto_build: true
      end
    end
  end
end
