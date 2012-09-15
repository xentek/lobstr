module Lobstr
  class Config
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
      raise Lobstr::Error::ConfigFileExists if File.exist?('config/lobstr.yml')
      Dir.mkdir('config') unless Dir.exist?('config')
      File.open("#{Dir.pwd}/config/lobstr.yml", 'w') {|f| f.write(template) }
      true
    end

    def reset
      File.delete('config/lobstr.yml')
      init
    end

    def parse(environment = 'production')
      YAML.load_file("config/lobstr.yml")[environment]
    end

    def print
      File.open('config/lobstr.yml', "r").readlines.join
    end
  end
end
