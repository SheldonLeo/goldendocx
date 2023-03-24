# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class AutoTitleDeletedProperty
        include Goldendocx::Element

        namespace :c
        tag :autoTitleDeleted

        attribute :enabled, alias_name: :val, default: true
      end
    end
  end
end
