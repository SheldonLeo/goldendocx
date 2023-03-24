# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class GraphicFrameLocksProperty
        include Goldendocx::Element

        namespace :a
        tag :graphicFrameLocks

        attribute :lock_position, alias_name: :noMove, default: true
        attribute :lock_size, alias_name: :noResize, default: true
        attribute :lock_aspect, alias_name: :noChangeAspect, default: true
      end
    end
  end
end
