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
  gem.summary       = gem.description 
  gem.homepage      = "https://github.com/xentek/lobstr"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('thor',    '0.16.0')
  gem.add_dependency('net-ssh', '2.5.2')
  gem.add_dependency('psych',   '1.3.4')

  gem.add_development_dependency('rake',     '0.9.2.2')
  gem.add_development_dependency('minitest', '3.4.0')
  gem.add_development_dependency('ansi',     '1.4.2')
  gem.add_development_dependency('turn',     '0.9.5')
end
