# frozen_string_literal: true

module Goldendocx
  module HasAttributes
    extend ActiveSupport::Concern

    included do
      class_attribute :attributes, instance_accessor: false, default: {}

      def unparsed_attributes
        @unparsed_attributes ||= {}
      end
    end

    class_methods do
      # alias_name: nil
      # readonly: false
      # default: nil
      # namespace: nil
      # setter: nil
      def attribute(name, **options)
        named = name.to_s
        attributes[named] = {
          alias_name: options[:alias_name],
          default: options[:default],
          namespace: options[:namespace],
          method: options[:method]
        }.compact

        readonly = options[:readonly] || false
        if readonly
          attr_reader named
        elsif options[:method]
          attr_writer named
        else
          attr_accessor named
        end
      end
    end

    def attributes
      self.class.attributes.each_with_object({}) do |(name, options), result|
        value = public_send(options[:method] || name) || options[:default]
        next if value.nil?

        key = [options[:namespace], options[:alias_name] || name].compact.join(':')
        result[key] = value
      end
    end

    def read_attributes(node)
      node_attributes = node.attributes_hash

      attributes = self.class.attributes.each_with_object({}) do |(name, options), result|
        attribute_tag = [options[:namespace], (options[:alias_name] || name)].compact.join(':')
        result[name] = node_attributes.delete(attribute_tag)
      end
      assign_attributes(**attributes)

      unparsed_attributes.update(node_attributes)
    end

    def assign_attributes(**attributes)
      attributes.each { |key, value| send("#{key}=", value) if respond_to?("#{key}=") }
    end
  end
end
