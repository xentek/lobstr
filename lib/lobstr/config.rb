module Lobstr
  class Config
    def template
      <<-TEMPLATE.gsub!(/^        /,'')
        lobstr:
          class: Lobstr::Deploy
          default:
            branch: 'master'
            environment: 'production'
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

    def parse
      YAML.load_file("config/lobstr.yml")['lobstr']
    end

    def print
      File.open('config/lobstr.yml', "r").readlines.join
    end
  end
end
