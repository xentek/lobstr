require 'lobstr'
begin; require 'turn/autorun'; rescue LoadError; end
Turn.config do |c|
  c.natural = true
  c.ansi = true
  c.format = :pretty
end

def clean_up_config_file(config_file = 'spec/config/lobstr.yml')
  config_path = File.dirname config_file
  File.delete config_file if File.exist? config_file
  Dir.delete config_path if Dir.exist? config_path
end
