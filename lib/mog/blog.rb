module Mog
  class Blog
    attr_reader :config

    def initialize(configuration)
      @config = configuration
    end

    def posts
      @config.posts_locations.map do |location|
        location.posts
      end.flatten
    end

    def posts_locations
      @config.posts_locations
    end

    private
      def method_missing(name, *args, &block)
        return @config.configured_value_for(name) if @config.configured?(name)
        super
      end

  end
end
