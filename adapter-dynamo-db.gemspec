# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adapter/dynamo-db/version"

Gem::Specification.new do |s|
  s.name        = "adapter-dynamo-db"
  s.version     = Adapter::DynamoDB::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/ajsharp/adapter-dynamo-db"
  s.summary     = %q{Ruby client for Amazon's DynamoDB}
  s.description = %q{Ruby client for Amazon's DynamoDB}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'aws-sdk', '~> 1.3.2'
  s.add_dependency 'adapter', '~> 0.5.2'
end
