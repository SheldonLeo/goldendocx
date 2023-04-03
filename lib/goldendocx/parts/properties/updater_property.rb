# frozen_string_literal: true

module Goldendocx
  module Parts
    module Properties
      class UpdaterProperty
        include Goldendocx::Element

        namespace :cp
        tag :lastModifiedBy

        embeds_one :name, class_name: 'String'
      end
    end
  end
end
