# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class ImageDataProperty
        include Goldendocx::Element

        namespace :v
        tag :imagedata

        attribute :relationship_id, alias_name: :id, namespace: :r
        attribute :title, namespace: :o
      end
    end
  end
end
