# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class FontProperty
        include Goldendocx::Element

        namespace :w
        tag :rFonts

        attribute :ascii, namespace: :w, default: 'Times New Roman'
        attribute :east_asia, alias_name: :eastAsia, namespace: :w, default: '宋体'
        attribute :high_ansi, alias_name: :hAnsi, namespace: :w, default: 'Times New Roman'
        attribute :complex, alias_name: :cs, namespace: :w, default: 'Times New Roman'
      end
    end
  end
end
