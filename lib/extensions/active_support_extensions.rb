# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/core_ext/array/access'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/class/subclasses'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/string/conversions'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.uncountable 'extents', 'image_data', 'data', 'defaults', 'latentStyles'
  inflect.irregular 'axis', 'axes'

  inflect.uncountable 'values' # TODO: Find better names
end
