# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class NonVisualProperty
        include Goldendocx::Element

        namespace :wp
        tag :docPr

        attribute :relationship_id, alias_name: :id
        attribute :name
      end
    end
  end
end
