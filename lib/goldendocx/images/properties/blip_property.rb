# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class BlipProperty
        include Goldendocx::Element

        namespace :a
        tag :blip

        attribute :relationship_id, alias_name: :embed, namespace: :r
      end
    end
  end
end
