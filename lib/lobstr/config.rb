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
          repos: git://github.com/xentek/lobstr.git
          path: ~/lobstr
          ssh_host: localhost
          ssh_user: xentek 
          ssh_key:  ~/.ssh/id_rsa
          branch: master
          environment: production
        production:
          <<: *defaults
      TEMPLATE
    end

    def create 
      raise Lobstr::Error::ConfigFileExists, @config_file if config_file_exists?
      Dir.mkdir(@config_path) unless Dir.exist?(@config_path)
      File.open(@config_file, 'w') {|f| f.write(template) }
    end

    def reset 
      File.delete(@config_file) if config_file_exists?
      create
    end

    def parse(environment = 'production')
      check_config_file
      config = YAML.load_file(@config_file)[environment]
      raise Lobstr::Error::InvalidEnvironment, environment if config.nil?
      config
    end

    def print
      check_config_file
      File.open(@config_file, 'r').read
    end

    private
    
    def config_file_exists?
      File.exist? @config_file
    end

    def check_config_file
      unless config_file_exists?
        raise Lobstr::Error::ConfigFileMissing, @config_file
      end
    end
  end
end
