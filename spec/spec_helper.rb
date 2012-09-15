require 'lobstr'
begin; require 'turn/autorun'; rescue LoadError; end
Turn.config do |c|
  c.natural = true
  c.ansi = true
  c.format = :pretty
end

def clean_up_config_file
  File.delete 'config/lobstr.yml' if File.exist? 'config/lobstr.yml'
  Dir.delete 'config' if Dir.exist? 'config'
end
