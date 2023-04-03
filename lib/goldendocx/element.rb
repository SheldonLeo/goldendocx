# frozen_string_literal: true

module Goldendocx
  module Element
    extend ActiveSupport::Concern

    included do
      class_attribute :attributes, instance_accessor: false, default: {}
      class_attribute :children, instance_accessor: false, default: {}

      def unparsed_attributes
        @unparsed_attributes ||= {}
      end

      def unparsed_children
        @unparsed_children ||= []
      end
    end

    class_methods do
      def tag(*args)
        @tag = args.first if args.any?
        @tag
      end

      def namespace(*args)
        @namespace = args.first if args.any?
        @namespace
      end

      def root_tag
        @root_tag ||= [namespace, tag].compact.join(':')
      end

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

      def create_children_getter(name)
        define_method name do
          return instance_variable_get("@#{name}") if instance_variable_defined?("@#{name}")

          instance_variable_set("@#{name}", self.class.default_value(name))
        end
      end

      def default_value(name)
        options = children[name]

        return [] if options[:multiple]

        options[:class_name].constantize.new if options[:auto_build]
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

      def concerning_ancestors
        ancestors.filter { |ancestor| ancestor.include?(Goldendocx::Element) }
      end

      def read_from(xml_node, multiple: false)
        nodes = Goldendocx.xml_serializer.search(xml_node, [root_tag])
        nodes.each { |n| xml_node.unparsed_children.delete(n) }

        instances = nodes.map do |node|
          new_instance = new
          new_instance.read_attributes(node)
          new_instance.read_children(node)
          new_instance.unparsed_children.concat node.unparsed_children.to_a
          new_instance
        end

        multiple ? Array(instances) : instances.first
      end

      private

      # :nocov:
      def warning_naming_suggestion(method, name, suggestion_name)
        return if suggestion_name == name.to_s

        location = caller.find { |c| c.include?('goldendocx/') && !c.include?('goldendocx/element.rb') }
        warn "warning: [#{method}] `#{name}` better be `#{suggestion_name}` at #{location}"
      end

      # :nocov:
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

    def tag
      self.class.concerning_ancestors.find { |ancestor| ancestor.tag.present? }&.tag
    end

    def namespace
      self.class.concerning_ancestors.find { |ancestor| ancestor.namespace.present? }&.namespace
    end

    def root_tag
      @root_tag ||= [namespace, tag].compact.join(':')
    end

    def children
      self.class.children.keys.flat_map { |name| send(name) }.compact
    end

    def read_children(node)
      self.class.children.each do |name, options|
        child_class = options[:class_name].constantize
        children = child_class.read_from(node, multiple: options[:multiple])
        instance_variable_set("@#{name}", children)
      end
    end

    def to_element(**context, &block)
      Goldendocx.xml_serializer.build_element(root_tag, **context) { |xml| build_element(xml, &block) }
    end

    def to_xml(&block)
      Goldendocx.xml_serializer.build_xml(root_tag) { |xml| build_element(xml, &block) }
    end

    def build_element(xml)
      attributes.each { |name, value| xml[name] = value }
      unparsed_attributes.each { |name, value| xml[name] = value }

      children.each { |child| xml << child }
      unparsed_children.each { |child| xml << child }

      yield(xml) if block_given?
    end
  end
end
