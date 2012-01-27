# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "depot/version"

Gem::Specification.new do |s|
  s.name        = "depot"
  s.version     = Depot::VERSION
  s.authors     = ["Rainer Borene"]
  s.email       = ["me@rainerborene.com"]
  s.homepage    = "https://github.com/rainerborene/depot"
  s.summary     = %q{Populate your database in an elegant way}
  s.description = %q{A simple DSL for defining database seeds in Rails.}

  s.rubyforge_project = "depot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "active_support", ">= 3.0.0"

  s.add_development_dependency "rspec"       , "~> 2.8"
  s.add_development_dependency "pry"         , "~> 0.9"
  s.add_development_dependency "guard-rspec" , "~> 0.6"
  s.add_development_dependency "libnotify"   , "~> 0.7"
end
