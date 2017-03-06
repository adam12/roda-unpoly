Gem::Specification.new do |spec|
  spec.name = "roda-unpoly"
  spec.version = "0.2.0"
  spec.authors = ["Adam Daniels"]
  spec.email = "adam@mediadrive.ca"

  spec.summary = %q(Integrate Unpoly with Roda)
  spec.homepage = "https://github.com/adam12/roda-unpoly"
  spec.license = "MIT"

  spec.files = ["README.md", "Rakefile"] + Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "roda", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2"
  spec.add_development_dependency "rack-test", "~> 0.6"
end
