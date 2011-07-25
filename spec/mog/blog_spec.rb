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

    context 'working with posts' do
      let(:published1) { double(:post, published?: true) }
      let(:published2) { double(:post, published?: true) }
      let(:unpublished){ double(:post, published?: false) }
      let(:location){ stub(:location, posts:[unpublished, published2, published1]) }

      before do
        published1.stub(:<=>).with(published2).and_return(1)
        published2.stub(:<=>).with(published1).and_return(-1)
        config.stub(:posts_locations).and_return([location])
        config.stub(:configured?).and_return(false)
      end

      describe '#posts' do
        it 'returns the posts at every configured location' do
          @blog.posts.should include(published1, published2, unpublished)
        end
      end

      describe '#published_posts' do
        it 'returns every published post' do
          @blog.published_posts.should include(published1, published2)
        end

        it 'does not return posts that have not been published yet' do
          @blog.published_posts.should_not include(unpublished)
        end

        it 'orders the posts by publication time (newest fist)' do
          @blog.published_posts.should == [published2, published1]
        end
      end

      describe '#each_published_post' do
        it 'yields every published post' do
          yielded_posts = []
          @blog.each_published_post{ |p| yielded_posts << p }
          yielded_posts.should include(published1, published2)
        end
      end

      describe '#published_post_with_url url' do
        context 'if a post with the url exists and is published' do
          it 'returns the post' do
            the_url = 'the-post-title-urlified'
            published1.stub(:url).and_return(the_url)
            published2.stub(:url).and_return('another-url')
            @blog.published_post_with_url(the_url).should be(published1)
          end
        end

        context 'a post with the url exists but is not published' do
        end

        context 'no post with given url exists' do
        end
      end

    end
  end
end
