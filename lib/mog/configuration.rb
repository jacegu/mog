module Mog
  class Configuration
    attr_reader :posts_locations

    def initialize
      @options = {}
      @posts_locations = []
    end

    def configured_options
      @options.keys
    end

    def set(option, value)
      @options[option] = value
    end

    def configured_value_for(option)
      raise UnknownOption unless configured?(option)
      @options[option]
    end

    def configured?(option)
      @options.has_key?(option)
    end

    def add_posts_location(location)
      @posts_locations << location
    end
  end

  class UnknownOption < Exception
  end
end
