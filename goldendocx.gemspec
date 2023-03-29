# frozen_string_literal: true

lib = File.expand_path(__dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/goldendocx/version'

Gem::Specification.new do |spec|
  spec.name    = 'goldendocx'
  spec.version = Goldendocx::VERSION
  spec.authors = ['WangYuechen']
  spec.email   = ['291943739@qq.com']

  spec.summary     = 'The Ruby API for Microsoft Word'
  spec.description = 'Ruby APIs for manipulating Microsoft Word based upon OOXML standards.'
  spec.homepage    = 'https://github.com/SheldonLeo/goldendocx'

  spec.required_ruby_version = '>= 2.7.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = ''

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 7.0'
  spec.add_dependency 'nokogiri', '~> 1.14'
  spec.add_dependency 'ox', '~> 2.14'
  spec.add_dependency 'rubyzip', '~> 2.3'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.11'
  spec.add_development_dependency 'rubocop', '~> 1.25'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-lcov'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
