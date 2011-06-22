module Mog
  class Engine < Sinatra::Application

    def self.config
      @@config ||= Configuration.new
    end

    def self.configure
      yield config
    end

    before do
      @blog = Blog.new(@@config)
    end

    get '/' do
      erb :index
    end
  end
end
