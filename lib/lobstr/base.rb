require 'minitest/mock'
module Lobstr
  class Base
    attr_accessor :app, :branch, :environment, :config, :ssh
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

    def connect(&block)
      @ssh = ::Net::SSH.start(@config['ssh_host'], 
                              @config['ssh_user'], 
                              :keys => [@config['ssh_key']],
                              :auth_methods => ['publickey'])
      instance_eval(&block) if block_given? 
    end

    def remote_task(cmd)
      @ssh.exec! cmd
    end

    def local_task(cmd)
      `#{cmd}`
    end
  end
end
