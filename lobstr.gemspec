# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lobstr/version'

Gem::Specification.new do |gem|
  gem.name          = "lobstr"
  gem.version       = Lobstr::VERSION
  gem.authors       = ["Eric Marden"]
  gem.email         = ["eric@xentek.net"]
  gem.description   = %q{deployments so easy, even a zoidberg can do it}
  gem.summary       = %q{lob branch@environment}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('thor')
  gem.add_dependency('net-ssh')

  gem.add_development_dependency('minitest', '3.4.0')
  gem.add_development_dependency('ansi')
  gem.add_development_dependency('turn')

end
