# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class Reference
        include Goldendocx::Element

        namespace :c
        tag :chart

        attribute :relationship_id, alias_name: :id, namespace: :r
      end
    end
  end
end
