module Mog
  class Blog
    attr_reader :config

    def initialize(configuration)
      @config = configuration
    end

    def published_posts
      posts.select{ |p| p.published? }.sort
    end

    def each_published_post
      published_posts.each { |p| yield p }
    end

    def posts
      @config.posts_locations.map{ |l| l.posts }.flatten
    end

    def posts_locations
      @config.posts_locations
    end

    def published_post_with_url(url)
      published_posts.select{ |p| p.url == url }.first
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
