# frozen_string_literal: true

module Goldendocx
  module Element
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def tag(*args)
        @tag = args.first if args.any?
        @tag
      end

      def namespace(*args)
        @namespace = args.first if args.any?
        @namespace
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

      def attributes
        @attributes ||= {}
      end

      def create_children_getter(name)
        options = children[name]
        class_name = options[:class_name]
        multiple = options[:multiple]
        auto_build = options[:auto_build]

        define_method name do
          return instance_variable_get("@#{name}") if instance_variable_defined?("@#{name}")

          default_value = if multiple
                            []
                          else
                            auto_build ? Kernel.const_get(class_name).new : nil
                          end
          instance_variable_set("@#{name}", default_value)
        end
      end

      def create_children_setter(name)
        options = children[name]
        class_name = options[:class_name]

        define_method "#{name}=" do |value|
          value = value.to_s if value && class_name == 'String'
          instance_variable_set("@#{name}", value)
        end
      end

      def create_children_builder(name)
        options = children[name]
        class_name = options[:class_name]
        multiple = options[:multiple]

        define_method "build_#{name.to_s.singularize}" do |**attributes|
          child = Kernel.const_get(class_name).new
          attributes.each { |key, value| child.send("#{key}=", value) if child.respond_to?("#{key}=") }
          multiple ? send(name) << child : instance_variable_set("@#{name}", child)
          child
        end
      end

      def embeds_one(name, class_name:, auto_build: false)
        warning_naming_suggestion(__method__, name, name.to_s.singularize)

        children[name] = { class_name: class_name, multiple: false, auto_build: auto_build }
        create_children_getter(name)
        create_children_setter(name)
        create_children_builder(name)
      end

      def embeds_many(name, class_name:)
        warning_naming_suggestion(__method__, name, name.to_s.pluralize)

        children[name] = { class_name: class_name, multiple: true, auto_build: false }
        create_children_getter(name)
        create_children_builder(name)
      end

      def children
        @children ||= {}
      end

      def concerning_ancestors
        ancestors.filter { |ancestor| ancestor.include?(Goldendocx::Element) }
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

    def siblings
      return [] unless self.class.superclass.include?(Goldendocx::Element)

      self.class.superclass.children.keys.flat_map { |name| send(name) }
    end

    def children
      self.class.children.keys.flat_map do |name|
        send(name)
      end.concat(siblings).compact
    end

    def to_element(**context)
      Goldendocx.xml_serializer.build_element(root_tag, **context) do |xml|
        attributes.each { |name, value| xml[name] = value }
        children.each { |child| xml << child }

        yield(xml) if block_given?
      end
    end

    def to_xml
      Goldendocx.xml_serializer.build_xml(root_tag) do |xml|
        attributes.each { |name, value| xml[name] = value }

        yield(xml) if block_given?

        children.each { |child| xml << child }
      end
    end
  end
end
