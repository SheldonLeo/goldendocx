# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  if ENV['CI']
    require 'simplecov-lcov'

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = 'coverage/lcov.info'
    end

    formatter SimpleCov::Formatter::LcovFormatter
  end

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
# Goldendocx.configure { |config| config.xml_serializer = :nokogiri }

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec::Matchers.define_negated_matcher :not_change, :change
