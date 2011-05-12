module Mog
  class Blog
    def configure
      @config ||= Configuration.new
    end
  end
end
