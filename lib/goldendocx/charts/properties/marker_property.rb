# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class MarkerProperty
        include Goldendocx::Element

        namespace :c
        tag :marker

        embeds_one :symbol, class_name: 'Goldendocx::Charts::Properties::SymbolProperty', auto_build: true
      end
    end
  end
end
