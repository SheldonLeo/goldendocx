# frozen_string_literal: true

module Goldendocx
  module Charts
    module Properties
      class DataLabelsProperty
        include Goldendocx::Element

        namespace :c
        tag :dLbls

        embeds_one :hidden, class_name: 'Goldendocx::Charts::Properties::LabelHiddenProperty', auto_build: true
      end
    end
  end
end
