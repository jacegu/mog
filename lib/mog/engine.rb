module Mog
  class Engine < Sinatra::Application

    def self.config
      @@config ||= Configuration.new
    end

    def self.configure
      yield @@config
    end

    get '/' do
      'works'
    end
  end
end
