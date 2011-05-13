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

    describe '#url' do
      it 'returns the post title' do
        the_title = 'title'
        post = a_post_entitled(the_title)
        post.url.should == the_title
      end

      it 'repaces the spaces in the title with "-"' do
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
    end
  end
end
