# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "paymill/version"

Gem::Specification.new do |s|
  s.name        = "paymill"
  s.version     = Paymill::VERSION
  s.authors     = ["Stefan Sprenger"]
  s.email       = ["stefan.sprenger@dkd.de"]
  s.homepage    = "https://github.com/dkd/paymill"
  s.summary     = %q{API wrapper for Paymill.}
  s.description = %q{API wrapper for Paymill.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "json"
  s.add_development_dependency "rspec"
end