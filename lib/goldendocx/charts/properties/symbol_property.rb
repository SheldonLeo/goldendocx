# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class SymbolProperty
        include Goldendocx::Element

        namespace :c
        tag :symbol

        attribute :type, alias_name: :val, default: :dot
      end
    end
  end
end
