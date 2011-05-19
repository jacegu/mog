module Mog
  class Configuration

    DEFAULT_OPTIONS = {blog_name:'', blog_description:'', view_markup: :haml }

    def initialize
      @options = DEFAULT_OPTIONS
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
