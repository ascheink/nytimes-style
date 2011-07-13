# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nytimes-style/version"

Gem::Specification.new do |s|
  s.name        = "nytimes-style"
  s.version     = Nytimes::Style::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrei Scheinkman", "Tyson Evans"]
  s.email       = ["andrei@nytimes.com", "tyson.evans@nytimes.com"]
  s.homepage    = "http://github.com/ascheink/nytimes-style"
  s.summary     = %q{New York Times style}
  s.description = %q{Format numbers and dates according to The New York Times Manual of Style}
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
