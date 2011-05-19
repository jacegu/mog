module Mog
  class Configuration
    def initialize
      @options = {}
    end

    def set(option_name, option_value)
      @options[option_name] = option_value
    end

    def method_missing(name, *args, &block)
      return @options[name] if @options.has_key?(name)
      super
    end

  end
end
