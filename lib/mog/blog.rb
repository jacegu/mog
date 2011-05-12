module Mog
  class Blog
    attr_reader :config
    def initialize(configuration)
      @config = configuration
    end
  end
end
