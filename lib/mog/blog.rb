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
        if @config.configured?(name)
          return @config.configured_value_for(name)
        else
          return send "blog_#{name}" unless name.to_s.start_with?('blog_')
        end
        super
      end

  end
end
