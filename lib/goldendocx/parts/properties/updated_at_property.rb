# frozen_string_literal: true

module Goldendocx
  module Parts
    module Properties
      class UpdatedAtProperty
        include Goldendocx::Element

        namespace :dcterms
        tag :modified

        attribute :type, namespace: :xsi, default: 'dcterms:W3CDTF'
        embeds_one :timestamp, class_name: 'Time'
      end
    end
  end
end
