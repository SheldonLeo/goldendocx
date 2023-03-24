# frozen_string_literal: true

module Goldendocx
  module Tables
    module Properties
      class ShadingProperty
        include Goldendocx::Element

        namespace :w
        tag :shd

        attribute :value, alias_name: :val, namespace: :w
        attribute :color, namespace: :w
        attribute :fill, namespace: :w
      end
    end
  end
end
