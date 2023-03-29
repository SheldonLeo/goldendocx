# frozen_string_literal: true

module Goldendocx
  module Models
    class Relationships
      include Goldendocx::Document

      NAMESPACE = 'http://schemas.openxmlformats.org/package/2006/relationships'

      tag :Relationships
      attribute :xmlns, default: NAMESPACE, readonly: true

      embeds_many :relationships, class_name: 'Goldendocx::Models::Relationship'

      def size
        relationships.size
      end

      def read_from(docx_file)
        paths = %w[Relationships Relationship]
        Goldendocx.xml_serializer.parse(docx_file.read(xml_path), paths).map do |node|
          build_relationship(id: node[:Id], type: node[:Type], target: node[:Target])
        end
      end

      def write_to(zos)
        zos.put_next_entry xml_path
        zos.write to_document_xml
      end

      def add_relationship(type, target)
        relationship_id = "rId#{relationships.size + 1}"
        build_relationship(id: relationship_id, type: type, target: target)
        relationship_id
      end
    end
  end
end
