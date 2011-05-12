module Mog
  class Engine < Sinatra::Application

    def self.configure
      @@config ||= Configuration.new
    end

    get '/' do
      'works'
    end
  end
end
