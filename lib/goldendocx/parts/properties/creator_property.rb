# frozen_string_literal: true

module Goldendocx
  module Parts
    module Properties
      class CreatorProperty
        include Goldendocx::Element

        namespace :dc
        tag :creator

        embeds_one :name, class_name: 'String'
      end
    end
  end
end
