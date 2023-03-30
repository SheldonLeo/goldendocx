# frozen_string_literal: true

module Goldendocx
  module Parts
    module Properties
      class CreatedAtProperty
        include Goldendocx::Element

        namespace :dcterms
        tag :created

        attribute :type, namespace: :xsi, default: 'dcterms:W3CDTF'
        embeds_one :timestamp, class_name: 'Time'
      end
    end
  end
end
