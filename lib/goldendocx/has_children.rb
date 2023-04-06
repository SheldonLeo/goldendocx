# frozen_string_literal: true

require 'goldendocx/has_attributes'

module Goldendocx
  module HasChildren
    extend ActiveSupport::Concern

    included do
      class_attribute :children, instance_accessor: false, default: {}

      def unparsed_children
        @unparsed_children ||= []
      end
    end

    class_methods do
      def embeds_one(name, class_name:, auto_build: false)
        warning_naming_suggestion(__method__, name, name.to_s.singularize)

        self.children = children.merge(name => { class_name: class_name, multiple: false, auto_build: auto_build })
        create_children_getter(name)
        create_children_setter(name)
        create_children_builder(name)
      end

      def embeds_many(name, class_name:)
        warning_naming_suggestion(__method__, name, name.to_s.pluralize)

        self.children = children.merge(name => { class_name: class_name, multiple: true, auto_build: false })
        create_children_getter(name)
        create_children_builder(name)
      end

      def default_value(name)
        options = children[name]

        return [] if options[:multiple]

        options[:class_name].constantize.new if options[:auto_build]
      end

      def concerning_ancestors
        ancestors.filter { |ancestor| ancestor.include?(Goldendocx::Element) }
      end

      private

      def create_children_getter(name)
        define_method name do
          return instance_variable_get("@#{name}") if instance_variable_defined?("@#{name}")

          instance_variable_set("@#{name}", self.class.default_value(name))
        end
      end

      def create_children_setter(name)
        define_method("#{name}=") { |value| instance_variable_set("@#{name}", value) }
      end

      def create_children_builder(name)
        options = children[name]
        class_name = options[:class_name]
        multiple = options[:multiple]

        define_method "build_#{name.to_s.singularize}" do |**attributes|
          child = class_name.constantize.new
          attributes.each { |key, value| child.send("#{key}=", value) if child.respond_to?("#{key}=") }
          multiple ? send(name) << child : instance_variable_set("@#{name}", child)
          child
        end
      end

      # :nocov:
      def warning_naming_suggestion(method, name, suggestion_name)
        return if suggestion_name == name.to_s

        location = caller.find { |c| c.include?('goldendocx/') && !c.include?('goldendocx/element.rb') }
        warn "warning: [#{method}] `#{name}` better be `#{suggestion_name}` at #{location}"
      end

      # :nocov:
    end

    def children
      self.class.children.keys.flat_map { |name| send(name) }.compact
    end

    def read_children(xml_node)
      xml_node.children.each do |child_node|
        read_child(child_node)
      end
    end

    def read_child(child_node)
      name, options = self.class.children.find do |_, opts|
        opts[:class_name].constantize.adapt?(child_node)
      end
      if name.present?
        child = options[:class_name].constantize.read_from(child_node)
        options[:multiple] ? send(name) << child : send("#{name}=", child)
      else
        unparsed_children << child_node
      end
    end
  end
end
