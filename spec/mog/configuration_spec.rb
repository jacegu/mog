require 'spec_helper'

module Mog
  describe Configuration do

    describe '#set' do
      let(:config){ Configuration.new }

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
