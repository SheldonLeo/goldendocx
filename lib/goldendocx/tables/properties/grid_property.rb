# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class GridProperty
        include Goldendocx::Element

        namespace :w
        tag :tblGrid

        embeds_many :grid_columns, class_name: 'Goldendocx::Tables::Properties::GridColumnProperty'
      end
    end
  end
end
