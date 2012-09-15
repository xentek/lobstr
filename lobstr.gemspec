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
  gem.required_ruby_version = '>= 1.9.2'

  gem.add_runtime_dependency('psych',   '~> 1.3') unless RUBY_PLATFORM == 'java'
  
  gem.add_dependency('thor',    '~> 0.16')
  gem.add_dependency('net-ssh', '~> 2.5')

  gem.add_development_dependency('rake',     '~> 0.9.2')
  gem.add_development_dependency('minitest', '~> 3.4')
  gem.add_development_dependency('ansi',     '~> 1.4')
  gem.add_development_dependency('turn',     '~> 0.9')
  gem.add_development_dependency('pry',     '~> 0.9')
end
