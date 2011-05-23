#encoding: utf-8

require 'spec_helper'

def a_post_entitled(title)
  Mog::Post.new(title, 'description', 'content', DateTime.new)
end

def a_post_described_as(description)
  Mog::Post.new('title', description, 'content', DateTime.new)
end

def a_post_with_content(content)
  Mog::Post.new('title', 'description', content, DateTime.new)
end

def a_post_published_on(publication_time)
  Mog::Post.new('title', 'description', 'content', DateTime.parse(publication_time))
end

module Mog
  describe Post do
    describe '#new' do
      let(:the_title){ 'the post title' }
      let(:the_description){ 'the post description' }
      let(:the_content){ 'the post content' }
      let(:the_publication_time){ DateTime.new }

      before do
        @post = Post.new(the_title, the_description, the_content, the_publication_time)
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

      it 'is created with a publication time' do
        @post.publication_time.should == the_publication_time
      end
    end

    describe '#url' do
      it 'returns the post title in lowercase' do
        post = a_post_entitled('TiTLe')
        post.url.should == 'title'
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

    describe '#published?' do
      it 'is true if the publication time is past' do
        post = a_post_published_on('2011-01-01 10:00:00+00:00')
        post.should be_published
      end

      it 'is false otherwise' do
        post = a_post_published_on('99999-12-31 23:59:59+00:00')
        post.should_not be_published
      end
    end

    describe 'two posts' do
      context 'with the same title, description, content and publication time' do
        it 'are equal' do
          a_post       = Post.new('t', 'd', 'c', DateTime.parse('2011-01-01 10:00:00+00:00'))
          another_post = Post.new('t', 'd', 'c', DateTime.parse('2011-01-01 10:00:00+00:00'))
          a_post.should == another_post
          another_post.should == a_post
        end
      end

      context 'with different titles' do
        it 'are different' do
          a_post       = a_post_entitled('a')
          another_post = a_post_entitled('b')
          a_post.should_not == another_post
          another_post.should_not == a_post
        end
      end

      context 'with different descriptions' do
        it 'are different' do
          a_post       = a_post_described_as('a')
          another_post = a_post_described_as('b')
          a_post.should_not == another_post
          another_post.should_not == a_post
        end
      end

      context 'with different content' do
        it 'are different' do
          a_post       = a_post_with_content('a')
          another_post = a_post_with_content('b')
          a_post.should_not == another_post
          another_post.should_not == a_post
        end
      end

      context 'with different publication time' do
        it 'are different' do
          a_post       = a_post_published_on('2011-01-01')
          another_post = a_post_published_on('1999-12-12')
          a_post.should_not == another_post
          another_post.should_not == a_post
        end
      end
 
    end
  end
end
