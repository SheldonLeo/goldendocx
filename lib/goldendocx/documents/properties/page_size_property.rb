# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class PageSizeProperty
        include Goldendocx::Element

        namespace :w
        tag :pgSz

        attribute :width, alias_name: :w, namespace: :w, default: 11906
        attribute :height, alias_name: :h, namespace: :w, default: 16838
      end
    end
  end
end
