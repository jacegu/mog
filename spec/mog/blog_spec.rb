require 'spec_helper'

module Mog
  describe Blog do
    it 'is created with a configuration' do
      configuration = Configuration.new
      blog = Blog.new(configuration)
      blog.config.should be(configuration)
    end

    it 'can provide configuration values' do
      the_configured_name = 'the name'
      config = stub(:configuration)
      config.stub(:name).and_return(the_configured_name)
      blog =Blog.new(config)
      blog.name.should == the_configured_name
    end

    describe '#posts' do
      it 'returns the posts at every configured location' do
        post = double :post
        post_dir = stub :post_dir
        post_dir.should_receive(:posts).and_return([post])
        config = stub :config
        config.should_receive(:posts_locations).and_return([post_dir])
        Blog.new(config).posts.should == [post]
      end
    end
  end
end
