require 'spec_helper'

module Mog
  describe Engine do
    context 'configuration' do

      context 'if it has not been configured yet' do
        let(:the_configuration){ double(:configuration) }

        it 'creates a new configuration' do
          Configuration.should_receive(:new).and_return(the_configuration)
          Engine.configure.should be(the_configuration)
        end
      end

      context 'if it has already been configured' do
        it 'returns the existing configuration' do
          the_configuration = Engine.configure
          Engine.configure.should be(the_configuration)
        end
      end
    end
  end
end
