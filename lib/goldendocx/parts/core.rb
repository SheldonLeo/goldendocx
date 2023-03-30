# frozen_string_literal: true

module Goldendocx
  module Parts
    class Core
      include Goldendocx::Document

      NAMESPACE = 'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties'

      concern_namespaces :cp, :dc, :dcterms, :dcmitype, :xsi

      namespace :cp
      tag :coreProperties

      embeds_one :creator, class_name: 'Goldendocx::Parts::Properties::CreatorProperty'
      embeds_one :created_at, class_name: 'Goldendocx::Parts::Properties::CreatedAtProperty'
      embeds_one :revision, class_name: 'Goldendocx::Parts::Properties::RevisionProperty'
      embeds_one :updater, class_name: 'Goldendocx::Parts::Properties::UpdaterProperty'
      embeds_one :updated_at, class_name: 'Goldendocx::Parts::Properties::UpdatedAtProperty'

      class << self
        def read_from(xml_node, multiple: nil)
          core = super(xml_node, multiple: multiple)
          revision = (core.revision || core.build_revision)
          revision.value = revision.value + 1
          core.build_updater(name: "Goldendocx_#{Goldendocx::VERSION}")
          core.build_updated_at(timestamp: Time.now)
          core
        end
      end

      def initialize
        build_creator(name: "Goldendocx_#{Goldendocx::VERSION}")
        build_created_at(timestamp: Time.now)
      end

      def write_to(zos, xml_path)
        zos.put_next_entry xml_path
        zos.write to_document_xml
      end
    end
  end
end
