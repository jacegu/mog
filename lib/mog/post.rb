module Mog
  class Post
    attr_reader :title, :description, :content

    def initialize(title, description, content)
      @title = title
      @description = description
      @content = content
    end
  end
end
