# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class ExtentsProperty
        include Goldendocx::Element

        namespace :a
        tag :ext

        attribute :width, alias_name: :cx
        attribute :height, alias_name: :cy
      end
    end
  end
end
