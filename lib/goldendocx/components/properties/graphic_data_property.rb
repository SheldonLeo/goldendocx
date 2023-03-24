# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class GraphicDataProperty
        include Goldendocx::Element

        namespace :a
        tag :graphicData

        embeds_one :picture, class_name: 'Goldendocx::Images::Picture', auto_build: false
        embeds_one :chart, class_name: 'Goldendocx::Charts::Properties::Reference', auto_build: false
      end
    end
  end
end
