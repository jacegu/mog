require 'spec_helper'

require 'mog/pages'

module Mog
  describe Pages do
    let(:the_number_of_posts_per_page){ 2 }
    let(:the_blog){ stub(:blog, :posts_per_page => the_number_of_posts_per_page) }

    describe '::for blog' do
      it 'creates the pages for the blog' do
        Pages.for(the_blog).should_not be_nil
      end

      it "builds the pages based on the posts per page blog's configuration option" do
        pages = Pages.for(the_blog)
        pages.posts_per_page.should == the_number_of_posts_per_page
      end
    end

    describe '#pages' do
      context 'with only one page' do
        it "builds and returns the page with the blog's published posts" do
          a_post = double(:post)
          the_blog.stub(:published_posts).and_return([a_post])

          the_page = double(:page)
          Page.should_receive(:with_posts).with(a_post).and_return(the_page)

          Pages.for(the_blog).pages.should == [the_page]
        end
      end

      context 'with more than a page' do
        it "builds and returns each page given the blog's published posts" do
          post1 = double(:post)
          post2 = double(:post)
          post3 = double(:post)
          the_blog.stub(:published_posts).and_return([post1, post2, post3])

          first_page, second_page  = double(:page), double(:page)
          Page.should_receive(:with_posts).with(post1, post2).and_return(first_page)
          Page.should_receive(:with_posts).with(post3).and_return(second_page)

          Pages.for(the_blog).pages.should == [first_page, second_page]
        end
      end
    end
  end

  describe Page do
    let(:a_post){ double(:post) }
    let(:another_post){ double(:post) }
    let(:page_posts){ [a_post, another_post] }

    describe '::new' do
      it 'creates a page with given array of posts 'do
        Page.new([a_post, another_post]).posts.should == page_posts
      end
    end

    describe '::with_posts posts' do
      it 'creates a new page with given posts' do
        Page.with_posts(a_post, another_post).posts.should == page_posts
      end
    end

    describe '#each_post' do
      it 'yields every post in the page' do
        page = Page.with_posts(a_post, another_post)
        yielded_posts = []
        page.each_post{ |p| yielded_posts << p }
        yielded_posts.should == page_posts
      end
    end
  end
end
