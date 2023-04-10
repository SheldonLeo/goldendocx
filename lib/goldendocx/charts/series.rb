# frozen_string_literal: true

module Goldendocx
  module Charts
    class Series
      include Goldendocx::Element

      namespace :c
      tag :ser

      embeds_one :index, class_name: 'Goldendocx::Charts::Properties::IndexProperty', auto_build: true
      embeds_one :order, class_name: 'Goldendocx::Charts::Properties::OrderProperty', auto_build: true
      embeds_one :smooth, class_name: 'Goldendocx::Charts::Properties::SmoothProperty', auto_build: true
      embeds_one :marker, class_name: 'Goldendocx::Charts::Properties::MarkerProperty', auto_build: true
      embeds_one :text, class_name: 'Goldendocx::Charts::Properties::SeriesTextProperty', auto_build: true
      embeds_one :labels_property, class_name: 'Goldendocx::Charts::Properties::DataLabelsProperty', auto_build: true

      embeds_one :category_axis, class_name: 'Goldendocx::Charts::Properties::SeriesCategoryProperty', auto_build: true
      embeds_one :value_axis, class_name: 'Goldendocx::Charts::Properties::SeriesValueProperty', auto_build: true

      def initialize(**attributes)
        attributes.each do |name, value|
          send("#{name}=", value) if respond_to?("#{name}=")
        end
      end

      def categories=(categories)
        category_axis.values.build_count(count: categories.size)
        categories.each_with_index do |cat, index|
          point = category_axis.values.build_point(index:)
          point.build_value(value: cat)
        end
      end

      def values=(values)
        value_axis.values.build_count(count: values.size)
        values.each_with_index do |val, index|
          point = value_axis.values.build_point(index:)
          point.build_value(value: val)
        end
      end

      def id=(id)
        return unless id

        index.index = id
        order.order = id
      end

      def name=(name)
        return unless name

        text.value.value = name
      end
    end
  end
end
