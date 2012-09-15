module Lobstr
  module Error
    class ConfigFileExists < IOError
      def message
        "config/lobstr.yml already exists"
      end
    end
  end
end
