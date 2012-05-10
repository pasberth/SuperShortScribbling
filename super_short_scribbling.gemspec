Gem::Specification.new do |s|
  s.name = "super_short_scribbling"
  s.version = File.read("VERSION")
  s.authors = ["pasberth"]
  s.description = %{}
  s.summary = %q{}
  s.email = "pasberth@gmail.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.homepage = "http://github.com/pasberth/SuperShortScribbling"
  s.require_paths = ["lib"]
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "active_support"
  s.add_development_dependency "myoack"
  s.add_development_dependency "optparse"
  s.add_development_dependency "twitter"
end
