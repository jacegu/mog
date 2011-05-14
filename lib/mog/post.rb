module Mog
  class Post
    attr_reader :title, :description, :content

    def self.from_post_file(file)
    end

    def initialize(title, description, content)
      @title = title
      @description = description
      @content = content
    end

    def url
      url_chunks = title.split.map{ |chunk| chunk.gsub(/\W|_/, '') }
      url_chunks.join('-')
    end
  end
end
