# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class SectionProperty
        include Goldendocx::Element

        namespace :w
        tag :sectPr

        embeds_one :size, class_name: 'Goldendocx::Documents::Properties::PageSizeProperty', auto_build: true
        embeds_one :margin, class_name: 'Goldendocx::Documents::Properties::PageMarginProperty', auto_build: true
      end
    end
  end
end
