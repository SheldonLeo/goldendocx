# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class LabelHiddenProperty
        include Goldendocx::Element

        namespace :c
        tag :delete

        attribute :enabled, alias_name: :val, default: true
      end
    end
  end
end
