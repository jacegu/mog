module Mog
  class Pages
    include Enumerable

    def self.for(blog)
      new(blog)
    end

    def initialize(blog)
      @blog = blog
    end

    def each(&block)
      pages.each(&block)
    end

    def number(page_number)
      pages[page_number.pred]
    end

    def pages
      @blog.published_posts.each_slice(posts_per_page).map{ |s| Page.with_posts(*s) }
    end

    def posts_per_page
      @blog.posts_per_page
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
