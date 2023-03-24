# frozen_string_literal: true

module Goldendocx
  module Images
    module Properties
      class DrawingProperty
        include Goldendocx::Element

        namespace :pic
        tag :cNvPicPr
      end
    end
  end
end
