require 'date'

class DateTime
  def past?
    self < DateTime.now
  end
end

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

    def published?
      @publication_time.past?
    end

    def ==(other)
      @title == other.title and
        @description == other.description and
        @content == other.content and
        @publication_time == other.publication_time
    end
  end
end
