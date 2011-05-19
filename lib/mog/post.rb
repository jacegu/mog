module Mog
  class Post
    attr_reader :title, :description, :content, :publication_time

    def initialize(title, description, content, publication_time)
      @title = title
      @description = description
      @content = content
      @publication_time = publication_time
    end

    def url
      url = title.downcase
      url_chunks = url.split.map{ |chunk| chunk.gsub(/\W|_/, '') }
      url_chunks.join('-')
    end
  end
end
