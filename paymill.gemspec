# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paymill/version'

Gem::Specification.new do |gem|
  gem.name        = "paymill"
  gem.version     = Paymill::VERSION
  gem.authors     = ["Stefan Sprenger", "Kevin Melchert"]
  gem.email       = ["kevin.melchert@gmail.com"]
  gem.homepage    = "https://github.com/max-power/paymill-ruby"
  gem.summary     = %q{API wrapper for Paymill.}
  gem.description = %q{API wrapper for Paymill.}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'money'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'guard-minitest'
end