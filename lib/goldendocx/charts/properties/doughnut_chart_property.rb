# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class DoughnutChartProperty
        include Goldendocx::Element

        namespace :c
        tag :doughnutChart

        embeds_one :hole, class_name: 'Goldendocx::Charts::Properties::HoleProperty', auto_build: true
        embeds_many :series, class_name: 'Goldendocx::Charts::Series'
      end
    end
  end
end
