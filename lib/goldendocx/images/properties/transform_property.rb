# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class TransformProperty
        include Goldendocx::Element

        namespace :a
        tag :xfrm

        embeds_one :extents, class_name: 'Goldendocx::Images::Properties::ExtentsProperty', auto_build: true
      end
    end
  end
end
