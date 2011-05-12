require 'spec_helper'

module Mog
  describe Blog do
    it 'is created with a configuration' do
      configuration = Configuration.new
      blog = Blog.new(configuration)
      blog.config.should_not be_nil
    end

    it 'can provide configuration values' do
      the_configured_name = 'the name'
      config = stub(:configuration)
      config.stub(:name).and_return(the_configured_name)
      blog =Blog.new(config)
      blog.name.should == the_configured_name
    end
  end
end
