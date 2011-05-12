require 'spec_helper'

module Mog
  describe Blog do
    it 'is created with a configuration' do
      configuration = Configuration.new
      blog = Blog.new(configuration)
      blog.config.should_not be_nil
    end
  end
end
