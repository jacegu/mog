module Mog
  class PostFile < Post
    private :initialize
    attr_reader :source_file_content

    FIRST_LINE  = 0
    SECOND_LINE = 1
    THIRD_LINE  = 2
    FOURTH_LINE = 3
    LAST_LINE   = -1

    def self.from(file)
      post_file = new(file)
      if post_file.content_lines.empty?
        return NullPost.new
      else
        return post_file
      end
    end

    def initialize(file)
      @source_file_content = file.read
    end

    def publication_time
      DateTime.parse(content_lines[FIRST_LINE])
    end

    def title
      content_lines[SECOND_LINE]
    end

    def description
      content_lines[THIRD_LINE]
    end

    def content
      content_lines[FOURTH_LINE..LAST_LINE].join("\n")
    end

    def content_lines
      lines = @source_file_content.split("\n")
      lines_without_trail_spaces = lines.map{ |line| line.lstrip }.compact
      lines_without_trail_spaces.select{ |l| not l.empty? }
    end
  end
end
