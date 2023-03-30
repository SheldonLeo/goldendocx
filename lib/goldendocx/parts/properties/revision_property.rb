# frozen_string_literal: true

module Goldendocx
  module Parts
    module Properties
      class RevisionProperty
        include Goldendocx::Element

        namespace :cp
        tag :revision

        embeds_one :value, class_name: 'Integer'
      end
    end
  end
end
