# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class StyleNameProperty
        include Goldendocx::Element

        namespace :w
        tag :name

        attribute :name, alias_name: :val, namespace: :w
      end
    end
  end
end
