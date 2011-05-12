require 'spec_helper'

module Mog
  describe Configuration do

    describe '#set' do
      it 'sets the configuration option to the given value' do
        config = Configuration.new
        the_blog_name = 'Mog Blog'
        config.set :blog_name, the_blog_name
        config.blog_name.should be(the_blog_name)
      end
    end

  end
end
