# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class LanguageProperty
        include Goldendocx::Element

        namespace :w
        tag :lang

        attribute :complex, alias_name: :bidi, namespace: :w, default: 'ar-SA'
        attribute :east_asia, alias_name: :eastAsia, namespace: :w, default: 'zh-CN'
        attribute :latin, alias_name: :val, namespace: :w, default: 'en-US'
      end
    end
  end
end
