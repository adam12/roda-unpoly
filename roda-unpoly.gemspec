Gem::Specification.new do |spec|
  spec.name = "roda-unpoly"
  spec.version = "0.4.0"
  spec.authors = ["Adam Daniels"]
  spec.email = "adam@mediadrive.ca"

  spec.summary = "Integrate Unpoly with Roda"
  spec.homepage = "https://github.com/adam12/roda-unpoly"
  spec.license = "MIT"

  spec.files = ["README.md", "Rakefile"] + Dir["lib/**/*.rb"]

  spec.add_dependency "rack-unpoly"
  spec.add_dependency "roda", ">= 2.0", "< 4.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "standard", "~> 1.26"
end
