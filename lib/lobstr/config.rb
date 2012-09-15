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

    def init
      raise Lobstr::Error::ConfigFileExists if File.exist? config_file
      Dir.mkdir(config_path) unless Dir.exist?(config_path)
      File.open(config_file, 'w') {|f| f.write(template) }
      true
    end

    def reset
      File.delete(config_file) if File.exist? config_file
      init
    end

    def parse(environment = 'production')
      YAML.load_file(config_file)[environment]
    end

    def print
      File.open(config_file, 'r').readlines.join
    end

    private
    def check_config_file
      raise Lobstr::ConfigFileMissing unless File.exist? config_file
    end
  end
end
