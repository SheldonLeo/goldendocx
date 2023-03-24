# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class ChartProperty
        include Goldendocx::Element

        namespace :c
        tag :chart

        embeds_one :rounded_corner, class_name: 'Goldendocx::Charts::Properties::RoundedCornerProperty', auto_build: true
        embeds_one :plot_area, class_name: 'Goldendocx::Charts::Properties::PlotAreaProperty', auto_build: true
      end
    end
  end
end
