# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class GraphicFrameProperty
        include Goldendocx::Element

        namespace :wp
        tag :cNvGraphicFramePr

        embeds_one :locker, class_name: 'Goldendocx::Components::Properties::GraphicFrameLocksProperty', auto_build: true
      end
    end
  end
end
