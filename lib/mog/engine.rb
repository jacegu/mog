module Mog
  class Engine < Sinatra::Application

    def self.config
      @@config ||= Configuration.new
    end

    def self.configure
      yield config
    end

    get '/' do
      @blog = Blog.new(@@config)
      "#{@blog.name} by #{@blog.author}"
    end
  end
end
