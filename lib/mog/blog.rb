module Mog
  class Blog < Sinatra::Application
    get '/' do
      'works'
    end
  end
end
