# frozen_string_literal: true

module Goldendocx
  module HasAssociations
    extend ActiveSupport::Concern

    included do
      class_attribute :associations, default: {}
      class_attribute :relationships_xml_path

      delegate :add_relationship, to: :relationships
    end

    class_methods do
      def relationships_at(xml_path)
        self.relationships_xml_path = xml_path
      end

      def associate(name, class_name:, isolate: false)
        named = name.to_s
        associations[named] = { class_name: class_name, isolate: isolate }

        define_method named do
          return instance_variable_get("@#{name}") if instance_variable_defined?("@#{name}")

          new_instance = class_name.constantize.new
          instance_variable_set("@#{name}", new_instance)
        end
      end
    end

    def read_associations(docx_file)
      associations.each do |association, options|
        association_class = options[:class_name].constantize
        association_document_xml = docx_file.read(association_class::XML_PATH)
        instance_variable_set("@#{association}", association_class.parse(association_document_xml))
      end
    end

    def read_relationships(docx_file)
      @relationships = Goldendocx::Models::Relationships.parse(docx_file.read(relationships_xml_path))
    end

    def write_relationships(zos)
      relationships.write_to(zos, relationships_xml_path)
    end

    def relationships
      @relationships ||= Goldendocx::Models::Relationships.new
    end
  end
end
