module Lobstr
  class Config
    attr_accessor :config_file, :config_path

    def initialize(config = 'config/lobstr.yml')
      @config_file = config
      @config_path = File.dirname config
    end

    def template
      <<-TEMPLATE.gsub!(/^        /,'')
        lobstr: &defaults
          class: Lobstr::Deploy
          repos: git://github.com/xentek/lobstr.git
          path: /app
          ssh_host: localhost
          ssh_user: lobstr
          ssh_key:  ~/.ssh/id_rsa
          branch:   'master'
          environment: 'production'
        production:
          <<: *defaults
      TEMPLATE
    end

    def create 
      raise Lobstr::Error::ConfigFileExists, config_file if config_file_exists?
      Dir.mkdir(config_path) unless Dir.exist?(config_path)
      File.open(config_file, 'w') {|f| f.write(template) }
    end

    def reset
      check_config_file
      File.delete(config_file)
      create
    end

    def parse(environment = 'production')
      check_config_file
      YAML.load_file(config_file)[environment]
    end

    def print
      check_config_file
      File.open(config_file, 'r').readlines.join
    end

    private
    
    def config_file_exists?
      File.exist? config_file
    end

    def check_config_file
      unless config_file_exists?
        raise Lobstr::Error::ConfigFileMissing, config_file
      end
    end
  end
end
