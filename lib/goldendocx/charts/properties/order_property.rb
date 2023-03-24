# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class OrderProperty
        include Goldendocx::Element

        namespace :c
        tag :order

        attribute :order, alias_name: :val
      end
    end
  end
end
