# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/copy/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano3-copy"
  spec.version       = Capistrano3::Copy::VERSION
  spec.authors       = ["Jordi Polo"]
  spec.email         = ["mumismo@gmail.com"]
  spec.summary       = %q{A simple gem providing a copy strategy for Capistrano3}
  spec.description   = %q{Copy strategy for Capistrano3. It creates and local zip file, uploads and unpacks it in the server.}
  spec.homepage      = "https://github.com/Railsmania/capistrano3-copy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rubyzip', "~> 1.1"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
