# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class StyleProperty
        include Goldendocx::Element

        namespace :w
        tag :tblStyle

        attribute :style_id, alias_name: :val, namespace: :w
      end
    end
  end
end
