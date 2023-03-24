# frozen_string_literal: true

module Goldendocx
  class Configuration
    DEFAULT = {
      xml_serializer: :ox
    }.freeze

    attr_accessor :xml_serializer

    def initialize
      DEFAULT.each do |key, value|
        var_name = :"@#{key}"
        instance_variable_set var_name, value
      end
    end
  end
end
