# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class StyleProperty
        include Goldendocx::Element

        namespace :w
        tag :pStyle

        attribute :style_id, alias_name: :val, namespace: :w
      end
    end
  end
end
