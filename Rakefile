require "bundler/gem_tasks"

desc "run the specs"
task :spec do
  puts `bundle exec turn -Ispec spec/*_spec.rb`
end
task :default => :spec
task :test => :spec
task :specs => :spec
