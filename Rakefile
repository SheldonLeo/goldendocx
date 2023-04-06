# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:ox_compatible_spec) do |task|
  ENV['XML_SERIALIZER'] = 'ox'
  task.failure_message = 'Failed with ox xml serializer compatible'
end

RSpec::Core::RakeTask.new(:nokogiri_compatible_spec) do |task|
  ENV['XML_SERIALIZER'] = 'nokogiri'
  task.failure_message = 'Failed with nokogiri xml serializer compatible'
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['-P']
end

task default: %i[rubocop ox_compatible_spec nokogiri_compatible_spec]
