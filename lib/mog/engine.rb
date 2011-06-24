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
      redirect '/blog'
    end

    get '/blog' do
      send @blog.view_markup, :index
    end

    get '/blog/:post_url' do
      url = params[:post_url]
      @post = @blog.published_post_with_url(url)
      send @blog.view_markup, :post
    end
  end
end
