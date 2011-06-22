module Mog
  class PostDir
    def self.from(dir)
      new(dir)
    end

    def self.at(path)
      new(Dir.open(path))
    end

    def initialize(dir)
      @dir = dir
    end

    def path
      @dir.path
    end

    def entries
      @dir.entries.map{ |e| File.join(path, e) }
    end

    def post_file_entries
     entries.select{ |e| File.file?(e) }.grep(/.*\/.+\.post\.(html|haml)$/i)
    end

    def posts
      post_file_entries.map{ |e| PostFile.from(File.open(e)) }
    end
  end
end
