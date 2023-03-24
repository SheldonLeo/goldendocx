# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class Inline
        include Goldendocx::Element

        namespace :w
        tag :inline

        embeds_one :extents, class_name: 'Goldendocx::Components::Properties::ExtentsProperty', auto_build: true
        embeds_one :padding, class_name: 'Goldendocx::Components::Properties::PaddingProperty', auto_build: true
        embeds_one :non_visual_property, class_name: 'Goldendocx::Components::Properties::NonVisualProperty', auto_build: true
        embeds_one :graphic_frame, class_name: 'Goldendocx::Components::Properties::GraphicFrameProperty', auto_build: true
        embeds_one :graphic, class_name: 'Goldendocx::Components::Properties::GraphicProperty', auto_build: true
      end
    end
  end
end
