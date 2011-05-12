module Mog
  class Blog
    attr_reader :config

    def initialize(configuration)
      @config = configuration
      define_readers_for_each_config_option
    end

    private

    def define_readers_for_each_config_option
      @config.instance_variables.each do |var|
        option = var.to_s.sub('@', '')
        define_reader_for(option)
      end
    end

    def define_reader_for(option)
      Blog.class_eval do
        define_method(option) do
          eval "@config.#{option}"
        end
      end
    end
  end
end
