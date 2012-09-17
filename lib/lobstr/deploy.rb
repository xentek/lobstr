module Lobstr
  class Deploy < ::Lobstr::Base
    def initialize(target, config_file = 'config/lobstr.yml', &block)
      @branch,@environment = parse_target(target)
      @config = Lobstr::Config.new(config_file).parse(@environment)
      return self.instance_eval(&block) if block_given?
      deploy
    end

    def deploy
      puts "deploying #{@branch} to #{@environment}"
      connect do
        update
        puts notify
      end
    end

    def setup
      # clone the repos
      # export foreman to upstart
    end
    
    def update
      puts "pull the latest from #{@config['repos']}"
      remote_task "cd #{@config['path']}"
      remote_task "git fetch origin"
      remote_task "git reset --hard #{@branch}"
      puts "setting restore point"
      remote_task "cd #{@config['path']}"
      remote_task 'git reflog delete --rewrite HEAD@{1}'
      remote_task 'git reflog delete --rewrite HEAD@{1}'    
    end

    def restart
      # restart the app via upstart
    end

    def rollback
      puts "rollback deployment"
      remote_task "cd #{@config['path']}"
      remote_task "git fetch origin"
      remote_task "git reset --hard HEAD@{1}"
    end

    def notify(event = :deployment)
      "notify of #{event}"
    end

  end
end
