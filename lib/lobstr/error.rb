module Lobstr
  module Error

    class ConfigFileExists < RuntimeError
      def initialize(config_file)
        super "#{config_file} already exists"
      end
    end

    class ConfigFileMissing < RuntimeError
      def initialize(config_file)
        super "#{config_file} is missing. try: \n\n$ lob config --init"
      end
    end

  end
end
