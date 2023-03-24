# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class BoldProperty
        include Goldendocx::Element

        namespace :w
        tag :b

        attribute :enabled, alias_name: :val, namespace: :w
      end
    end
  end
end
