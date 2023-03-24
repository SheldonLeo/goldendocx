# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class GridColumnProperty
        include Goldendocx::Element

        namespace :w
        tag :gridCol

        attribute :width, alias_name: :w, namespace: :w, default: Goldendocx::Tables::DEFAULT_CELL_DXA_WIDTH
      end
    end
  end
end
