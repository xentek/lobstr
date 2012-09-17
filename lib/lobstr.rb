# -*- encoding: utf-8 -*-

require 'yaml'
require 'net/ssh'
require 'highline/import'
require 'lobstr/base'
require 'lobstr/config'
require 'lobstr/deploy'
require 'lobstr/error'
require 'lobstr/version'

module Lobstr
  class << self ; attr_accessor :target ; end
end

def lobstr(target = nil, config_file = 'config/lobstr.yml', &block)
  target ||= Lobstr.target
  Lobstr::Deploy.new(target, config_file, &block)
end
