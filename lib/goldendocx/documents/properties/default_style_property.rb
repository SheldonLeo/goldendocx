# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class DefaultStyleProperty
        include Goldendocx::Element

        namespace :w
        tag :docDefaults

        embeds_one :run_default, class_name: 'Goldendocx::Documents::Properties::RunDefaultStyleProperty', auto_build: true
        embeds_one :paragraph_default, class_name: 'Goldendocx::Documents::Properties::ParagraphDefaultStyleProperty', auto_build: true
      end
    end
  end
end
