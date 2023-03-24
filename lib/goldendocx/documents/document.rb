# frozen_string_literal: true

module Goldendocx
  module Documents
    class Document
      include Goldendocx::Document

      XML_PATH = 'word/document.xml'

      namespace :w
      tag :document
      concern_namespaces :wpc, :o, :mo, :mv, :r, :m, :v, :wp14, :wp, :w10,
                         :w, :w14, :w15, :w16cid, :w16se, :wpg, :wpi, :wne, :wps, :mc,
                         :a, :a14, :pic, :c
      ignore_namespaces :w14, :w15, :w16se, :w16cid, :wp14

      embeds_one :body, class_name: 'Goldendocx::Documents::Body', auto_build: true

      def read_from(docx_file)
        body.read_from(docx_file)
      end

      def write_to(zos)
        zos.put_next_entry XML_PATH
        zos.write to_document_xml
      end
    end
  end
end
