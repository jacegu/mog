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
      @post = @blog.published_post_with_url params[:post_url]
      if @post
        send @blog.view_markup, :post
      else
        not_found
      end
    end

    get '/blog/page/:page_number' do
      @page = params[:page_number].to_i
      send @blog.view_markup, :index
    end

    not_found do
      '404'
    end
  end
end
