module Lobstr
  module Error

    class InvalidEnvironment < StandardError
      def initialize(environment)
        super "Invalid Environment: #{environment}. Can't load config."
      end
    end

    class ConfigFileExists < StandardError
      def initialize(config_file)
        super "#{config_file} already exists"
      end
    end

    class ConfigFileMissing < StandardError
      def initialize(config_file)
        super "#{config_file} is missing. try: \n\n$ lob config --init"
      end
    end

  end
end
