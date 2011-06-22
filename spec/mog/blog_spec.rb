require 'spec_helper'

module Mog
  describe Blog do
    let(:config){ double :configuration }

    before do
      @blog = Blog.new(config)
    end

    it 'is created with a configuration' do
      @blog.config.should be(config)
    end

    describe 'access configuration options as methods' do

      context 'if the option has been configured' do
        context 'if the option is not a blog option' do
          it 'returns the configured value' do
            the_configured_name = 'the option'
            config.stub(:configured?).with(:option).and_return(true)
            config.stub(:configured_value_for).with(:option).and_return(the_configured_name)
            @blog.option.should == the_configured_name
          end
        end

        context 'if the option is a blog option (starts with "blog_")' do
          it 'returns the configured value even without "blog_" prefix' do
            the_configured_name = 'mog'
            config.stub(:configured?).with(:name).and_return(false)
            config.stub(:configured?).with(:blog_name).and_return(true)
            config.stub(:configured_value_for).with(:blog_name).and_return(the_configured_name)
            @blog.name.should == the_configured_name
          end
        end
      end

      context 'if the option does not exits' do
        it 'raises a NoMethodError' do
          config.stub(:configured?).with(:blog_unknown_option).and_return(false)
          config.stub(:configured?).with(:unknown_option).and_return(false)
          expect{ @blog.unknown_option }.to raise_error NoMethodError
        end
      end
    end

    describe '#posts_locations' do
      it 'returns the locations that have been configured' do
        the_locations = [double, double]
        config.stub(:posts_locations).and_return(the_locations)
        @blog.posts_locations.should == the_locations
      end
    end

    describe '#posts' do
      it 'returns the posts at every configured location' do
        post = double :post
        post_dir = stub :post_dir
        post_dir.should_receive(:posts).and_return([post])
        config.should_receive(:posts_locations).and_return([post_dir])
        @blog.posts.should == [post]
      end
    end
  end
end
