# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paymill/version'

Gem::Specification.new do |spec|
  spec.name          = "paymill"
  spec.version       = Paymill::VERSION
  spec.authors       = ["Vassil Nikolov"]
  spec.email         = ["vassil.nikolov@qaiware.com"]
  spec.summary       = %q{Ruby wrapper for PAYMILL's API.}
  spec.homepage      = "https://github.com/paymill/paymill-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 4.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.20"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "guard-rspec", "~> 4.3"
end
