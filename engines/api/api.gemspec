$:.push File.expand_path("lib", __dir__)

Gem::Specification.new do |spec|
  spec.name        = "api"
  spec.version     = "0.1.0"
  spec.authors     = ["Florin Lipan"]
  spec.email       = ["florinlipan@gmail.com"]
  spec.homepage    = "https://github.com/lipanski/spaced"
  spec.summary     = "Spaced API"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "Rakefile"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"
end
