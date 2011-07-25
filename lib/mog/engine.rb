module Mog
  class Engine < Sinatra::Application

    set :show_exceptions, false

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
      @page = Pages.for(@blog).first
      send @blog.view_markup, :blog
    end

    get '/blog/:post_url' do
      @post = @blog.published_post_with_url params[:post_url]
      if @post
        send @blog.view_markup, :post
      else
        not_found
      end
    end

    not_found do
      '404'
    end

    error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    end
  end
end
