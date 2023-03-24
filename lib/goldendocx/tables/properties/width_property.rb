# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class WidthProperty
        include Goldendocx::Element

        namespace :w
        tag :tblW

        attribute :width, alias_name: :w, namespace: :w, default: Goldendocx::Tables::DEFAULT_TABLE_DXA_WIDTH
        attribute :type, namespace: :w, default: :dxa
      end
    end
  end
end
