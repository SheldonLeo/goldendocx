# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class Drawing
        include Goldendocx::Element

        namespace :w
        tag :drawing

        embeds_one :inline, class_name: 'Goldendocx::Components::Properties::Inline', auto_build: true
      end
    end
  end
end
