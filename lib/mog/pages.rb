module Mog
  class Pages
    include Enumerable

    DEFAULT_NUMBER_OF_POSTS_PER_PAGE = 5

    def self.for(blog)
      new(blog)
    end

    def initialize(blog)
      @blog = blog
    end

    def posts_per_page
      @blog.posts_per_page
    end

    def pages
      @blog.published_posts.each_slice(posts_per_page).map{ |s| Page.with_posts(*s) }
    end

    def each(&block)
      pages.each(&block)
    end
  end

  class Page
    attr_reader :posts

    def self.with_posts(*posts)
      new(posts)
    end

    def initialize(posts)
      @posts = posts
    end

    def each_post(&block)
      @posts.each(&block)
    end
  end
end
