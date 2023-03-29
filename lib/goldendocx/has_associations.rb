# frozen_string_literal: true

module Goldendocx
  module HasAssociations
    extend ActiveSupport::Concern

    included do
      class_attribute :associations, default: {}
    end

    class_methods do
      def associate(name, class_name:, path:)
        named = name.to_s
        associations[named] = { class_name: class_name, path: path }

        association_class = class_name.constantize

        define_method named do
          return instance_variable_get("@#{name}") if instance_variable_defined?("@#{name}")

          new_instance = association_class.new.tap do |instance|
            instance.define_singleton_method(:xml_path) { path }
          end
          instance_variable_set("@#{name}", new_instance)
        end
      end
    end
  end
end
