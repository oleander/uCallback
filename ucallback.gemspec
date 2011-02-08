# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ucallback/version"

Gem::Specification.new do |s|
  s.name        = "ucallback"
  s.version     = Ucallback::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Linus Oleander"]
  s.email       = ["linus@oleander.nu"]
  s.homepage    = ""
  s.summary     = %q{Makes it possible to call a script when a download finishes, using uTorrent}
  s.description = %q{The missing link between uTorrent and the console in OS X}

  s.rubyforge_project = "ucallback"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency('rspec') 
end
