require 'spec_helper'

module Mog
  describe Blog do

    context 'configuration' do
      let(:the_configuration){ double :configuration }

      context 'if it has not been configured already' do
        it 'creates a new configuration' do
          Configuration.should_receive(:new).and_return(the_configuration)
          Blog.new.configure.should be the_configuration
        end
      end

      context 'if it has already been configured' do
        it 'returns the existing configuration' do
          Configuration.should_receive(:new).once.and_return(the_configuration)
          blog = Blog.new
          blog.configure
          blog.configure.should be the_configuration
        end
      end
    end
  end
end
