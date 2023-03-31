# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class ParagraphDefaultStyleProperty
        include Goldendocx::Element

        namespace :w
        tag :pPrDefault

        embeds_one :property, class_name: 'Goldendocx::Components::Properties::Property'
      end
    end
  end
end
