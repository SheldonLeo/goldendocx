# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class PictureFillProperty
        include Goldendocx::Element

        namespace :pic
        tag :blipFill

        embeds_one :blip, class_name: 'Goldendocx::Images::Properties::BlipProperty', auto_build: true
        embeds_one :stretch, class_name: 'Goldendocx::Images::Properties::StretchProperty', auto_build: true
      end
    end
  end
end
