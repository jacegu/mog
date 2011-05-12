module Mog
  class Engine < Sinatra::Application
    get '/' do
      'works'
    end
  end
end
