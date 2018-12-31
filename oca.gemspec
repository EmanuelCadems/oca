# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oca/version'

Gem::Specification.new do |spec|
  spec.name          = "oca"
  spec.version       = Oca::VERSION
  spec.authors       = ["Emanuel Alarcón"]
  spec.email         = ["emanuel_cadems@hotmail.com"]
  spec.summary       = 'Oca sdk for Ruby'
  spec.description   = 'OCA SDK for Ruby on Rails'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency 'activesupport', '~> 4.1'
  spec.add_runtime_dependency 'json', '~> 1.8'
  spec.add_runtime_dependency 'httparty', '~> 0.13'
  spec.add_runtime_dependency 'activemodel', '~> 4.1'
end

