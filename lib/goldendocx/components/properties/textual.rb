# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class Textual
        include Goldendocx::Element

        namespace :w
        tag :t

        embeds_one :value, class_name: 'String'
      end
    end
  end
end
