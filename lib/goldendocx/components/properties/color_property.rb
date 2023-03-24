# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class ColorProperty
        include Goldendocx::Element

        namespace :w
        tag :color

        attribute :hex, alias_name: :val, namespace: :w
      end
    end
  end
end
