# frozen_string_literal: true

module Goldendocx
  module Components
    module Properties
      class AlignProperty
        include Goldendocx::Element

        namespace :w
        tag :jc

        attribute :align, alias_name: :val, namespace: :w
      end
    end
  end
end
