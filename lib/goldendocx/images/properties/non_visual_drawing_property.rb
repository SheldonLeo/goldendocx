# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class NonVisualDrawingProperty
        include Goldendocx::Element

        namespace :pic
        tag :cNvPr

        attribute :relationship_id, alias_name: :id
        attribute :name
      end
    end
  end
end
