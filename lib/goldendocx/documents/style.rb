# frozen_string_literal: true

module Goldendocx
  module Documents
    class Style
      include Goldendocx::Element

      namespace :w
      tag :style

      attribute :id, alias_name: :styleId, namespace: :w
      attribute :type, namespace: :w

      embeds_one :style_name, class_name: 'Goldendocx::Documents::Properties::StyleNameProperty', auto_build: true

      def name
        style_name.name
      end
    end
  end
end
