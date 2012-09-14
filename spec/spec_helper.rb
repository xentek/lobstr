require 'lobstr'
begin; require 'turn/autorun'; rescue LoadError; end
Turn.config do |c|
  c.natural = true
  c.ansi = true
  c.format = :pretty
end
