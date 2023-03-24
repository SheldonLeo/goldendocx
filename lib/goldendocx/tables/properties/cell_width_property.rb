# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class CellWidthProperty
        include Goldendocx::Element

        namespace :w
        tag :tcW

        attribute :width, namespace: :w, alias_name: :w
        attribute :type, namespace: :w, default: :auto
      end
    end
  end
end
