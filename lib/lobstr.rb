# -*- encoding: utf-8 -*-

require 'psych'
require 'yaml'
require 'lobstr/config'
require 'lobstr/deploy'
require 'lobstr/error'
require 'lobstr/version'

module Lobstr
  class Base
    def parse_target(target)
      branch,environment = target.split('@', 2)
 
      if environment.nil? # e.g. production
        environment = branch
        branch = 'master'
      end

      branch = "master" if branch.empty? # e.g. @production
      environment = "production" if environment.empty? # e.g. master@
      [branch,environment]
    end
  end
end
