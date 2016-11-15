# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'isilon_api/version'

Gem::Specification.new do |spec|
  spec.name          = "isilon_api"
  spec.version       = IsilonApi::VERSION
  spec.authors       = ["Chad Nelson"]
  spec.email         = ["chad.nelson@temple.edu"]

  spec.summary       = %q{Read only API calls for the Isilon OneFS api}
  spec.description   = %q{Read only API calls for the Isilon OneFS api.}
  spec.homepage      = "https://github.com/tulibraries/isilon_api"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]\

  #spec.add_dependency "faraday"
  spec.add_runtime_dependency "faraday", "~> 0"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 0"
  spec.add_development_dependency "pry", "~> 0"
end
