# frozen_string_literal: true

module Goldendocx
  module Documents
    class Settings
      include Goldendocx::Document

      XML_PATH = 'word/settings.xml'
      TYPE = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings'
      CONTENT_TYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml'

      namespace :w
      tag :settings
      concern_namespaces :mc, :o, :r, :m, :v, :w10, :w, :w14, :w15, :w16cid, :w16se, :sl
      ignore_namespaces :w14, :w15, :w16se, :w16cid

      def write_to(zos)
        zos.put_next_entry XML_PATH
        zos.write to_document_xml
      end
    end
  end
end
