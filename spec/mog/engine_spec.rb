require 'spec_helper'

module Mog
  describe Engine do
    context 'configuration' do

      describe '#config' do
        context 'if it has not been configured yet' do
          let(:the_configuration){ double(:configuration) }

          it 'creates a new configuration' do
            Configuration.should_receive(:new).and_return(the_configuration)
            Engine.config.should be(the_configuration)
          end
        end

        context 'if it has already been configured' do
          it 'returns the existing configuration' do
            the_configuration = Engine.config
            Engine.config.should be(the_configuration)
          end
        end
      end

      describe '#configure' do
        it 'yields the configuration' do
          the_configuration = double(:configuration)
          Engine.stub(:config).and_return(the_configuration)
          Engine.configure{ |c| @yielded_config = c }
          @yielded_config.should be(the_configuration)
        end
      end

    end
  end
end
