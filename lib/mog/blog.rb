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

    private
      def method_missing(name, *args, &block)
        @config.send(name)
      end

  end
end
