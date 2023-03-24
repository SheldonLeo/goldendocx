# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'demo/'

  add_group 'Charts', 'charts/'
  add_group 'Documents', 'documents/'
  add_group 'Components', 'components/'
  add_group 'Partitions', 'parts/'
  add_group 'Tables', 'tables/'

  refuse_coverage_drop
end

require 'goldendocx'
Goldendocx.configure { |config| config.xml_serializer = :ox }

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec::Matchers.define_negated_matcher :not_change, :change
