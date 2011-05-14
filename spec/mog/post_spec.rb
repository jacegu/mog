#encoding: utf-8

require 'spec_helper'

def a_post_entitled(title)
  Mog::Post.new(title, 'description', 'content')
end

module Mog
  describe Post do
    describe '#new' do
      let(:the_title){ 'the post title' }
      let(:the_description){ 'the post description' }
      let(:the_content){ 'the post content' }

      before do
        @post = Post.new(the_title, the_description, the_content)
      end

      it 'is created with a title' do
        @post.title.should == the_title
      end

      it 'is created with a description' do
        @post.description.should == the_description
      end

      it 'is created with a content' do
        @post.content.should == the_content
      end
    end

    describe '::from_post_file' do
      let(:the_file) { double(:post_file).as_null_object }

      it 'creates a post from the file' do
        Post.from_post_file(the_file).should be_a(Post)
      end

      it 'entitles the post with the title specified in the file' do
        the_title = 'the title taken from the file'
        the_file.should_receive(:title).and_return(the_title)
        Post.from_post_file(the_file).title.should == the_title
      end

      it 'gives the post the description specified in the file' do
        the_description = 'the description taken from the file'
        the_file.should_receive(:description).and_return(the_description)
        Post.from_post_file(the_file).description.should == the_description
      end

      it 'gives the post the content specified in the file' do
        the_content = '<p>the post content taken from the file</p>'
        the_file.should_receive(:content).and_return(the_content)
        Post.from_post_file(the_file).content.should == the_content
      end
    end

    describe '#url' do
      it 'returns the post title' do
        the_title = 'title'
        post = a_post_entitled(the_title)
        post.url.should == the_title
      end

      it 'replaces the spaces in the title with "-"' do
        post = a_post_entitled('a title with spaces')
        post.url.should == 'a-title-with-spaces'
      end

      it 'replaces tabs in the title with "-"' do
        post = a_post_entitled('a title with tabs')
        post.url.should == 'a-title-with-tabs'
      end

      it 'removes non alphanumeric characters' do
        post = a_post_entitled('&t.h·3,/ "p¡0!s(t) -[/t$1%t&l3?')
        post.url.should == 'th3-p0st-t1tl3'
      end

      it 'removes underscores "_"' do
        post = a_post_entitled('a_ title_ with_ underscores_')
        post.url.should == 'a-title-with-underscores'
      end
    end
  end
end
