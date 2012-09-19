module Lobstr
  class Deploy < ::Lobstr::Base
    def initialize(target, config_file = 'config/lobstr.yml', &block)
      @branch,@environment = parse_target(target)
      @config = Lobstr::Config.new(config_file).parse(@environment)
      @app = @config['app']
      if block_given?
        return instance_eval(&block)
      else
        return self
      end
    end

    def deploy
      connect do
        update
        bundle_install
        restart true
        notify
      end
    end
    
    def update
      remote_task "cd #{@config['path']}"
      remote_task "git fetch origin"
      remote_task "git reset --hard #{@branch}"
      remote_task "cd #{@config['path']}"
      remote_task 'git reflog delete --rewrite HEAD@{1}'
      remote_task 'git reflog delete --rewrite HEAD@{1}'    
    end

    def restart(sudo = true)
      sudoit = (sudo) ? 'sudo' : ''
      remote_task "#{sudoit} /etc/init.d/#{@config['app']}"
    end

    def rollback
      remote_task "cd #{@config['path']}"
      remote_task "git fetch origin"
      remote_task "git reset --hard HEAD@{1}"
    end

    def notify(event = :deployment)
      "notify of #{event}"
    end

    def setup(&block)
      return instance_eval(&block) if block_given?
      remote_task "git clone #{@config['repos']} #{@config['path']}"
      bundle_install
      export_foreman
    end

    def bundle_install(options = {})
      if config.has_key? 'bundler'
        options = @config['bundler'].merge(options)
      else
        options = {
          'deployment' => nil,
          'path' => 'vendor/bundle',
          'without' => 'development test'
        }.merge(options)
      end
      options_string = ''
      options.each { |k,v| options_string += "--#{k} #{v} " }
      remote_task "bundle install #{options_string}"
    end

    def export_foreman(format='upstart', location='/etc/init', options={})
      valid_formats = ['bluepill','inittab','runit','upstart']
      unless valid_formats.include? format
        raise Lobstr::Error::InvalidExportFormat
      end
      if @config.has_key? 'foreman'
        options = @config['foreman'].merge(options)
      else
        options = {
          'app'  => @config['app'],
          'log'  => "#{@config['path']}/log",
          'user' => @config['ssh_user'],
          'procfile' => "#{@config['path']}/Procfile"
        }.merge(options)
      end

      options_string = ''
      options.each { |k,v| options_string += "--#{k} #{v} " }
      
      remote_task "foreman export #{format} #{location} #{options_string}"
    end
  end
end
