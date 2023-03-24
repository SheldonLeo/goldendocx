# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class IndexProperty
        include Goldendocx::Element

        namespace :c
        tag :idx

        attribute :index, alias_name: :val
      end
    end
  end
end
