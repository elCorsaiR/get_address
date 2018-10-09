lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'get_address/version'

Gem::Specification.new do |spec|
  spec.name          = "get_address"
  spec.version       = GetAddress::VERSION
  spec.authors       = ['CorsaiR']
  spec.email         = ['alezander82@mail.ru']

  spec.summary       = 'Wrapper for the getaddress.io API'
  spec.description   = 'A simple API for finding postal addresses'
  spec.homepage      = 'http://rubygems.org/gems/get_address'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '>= 1.8', '< 3.0'
  spec.add_dependency 'virtus', '~> 1.0', '>= 1.0.5'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 2.3', '>= 2.3.1'
end
