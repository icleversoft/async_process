# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'async_process/version'

Gem::Specification.new do |spec|
  spec.name          = "async_process"
  spec.version       = AsyncProcess::VERSION
  spec.authors       = ["icleversoft"]
  spec.email         = ["iphone@icleversoft.com"]
  spec.summary       = %q{Simple gem for processing files}
  spec.description   = %q{This gem scans for files into directories and creates callbacks in order to process them}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>3.3"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"

end
