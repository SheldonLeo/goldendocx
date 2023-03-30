# frozen_string_literal: true

require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/class/subclasses'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/string/conversions'
require 'active_support/concern'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.uncountable 'extents', 'image_data', 'data'
  inflect.irregular 'axis', 'axes'

  inflect.uncountable 'values' # TODO: Find better names
end
