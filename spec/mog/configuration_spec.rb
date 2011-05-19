require 'spec_helper'

module Mog
  describe Configuration do
    let(:config){ Configuration.new }

    describe 'by default' do
      it 'has an empty blog name' do
        config.blog_name.should be_empty
      end

      it 'has an empty blog description' do
        config.blog_description.should be_empty
      end

      it 'has HAML as default view markup' do
        config.view_markup.should == :haml
      end
    end

    describe '#set' do
      it 'sets the configuration option to the given value' do
        the_blog_name = 'Mog Blog'
        config.set :blog_name, the_blog_name
        config.blog_name.should be(the_blog_name)
      end

      it 'raises NoMethodError when accessing a not configured option' do
        expect{ config.unknown_option }.to raise_error NoMethodError
      end
    end

  end
end
