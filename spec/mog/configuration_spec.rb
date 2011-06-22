require 'spec_helper'

module Mog
  describe Configuration do
    let(:config){ Configuration.new }

    it 'has no configured options by default' do
      config.configured_options.should be_empty
    end

    context 'configuring options' do
      let(:option){ :the_option }
      let(:value){ 'the value of the option' }

      before do
        config.set option, value
      end

      describe '#set' do
        it 'adds the option to the configured ones' do
          config.configured_options.should include(option)
        end

        it 'stores the configured value for the option' do
          config.configured_value_for(:the_option).should == value
        end
      end

      describe '#configured_value_for option' do
        context 'if the option has been configured' do
          it 'returns the configured value' do
            config.configured_value_for(:the_option).should == value
          end
        end

        context 'if the option has not been configured' do
          it 'raises an UnknownOption error' do
            expect{ config.configured_value_for(:unknown) }.to raise_error UnknownOption
          end
        end
      end

      describe '#configured? option' do
        it 'returns true if the option has been configured' do
          config.configured?(option).should be_true
        end

        it 'returns false if the option has not been configured' do
          config.configured?(:not_configured_option).should be_false
        end
      end
    end

    context 'configuring post locations' do
      let(:location){ double :a_location }

      describe '#posts_locations' do
        it 'has no configured post locations by default' do
          config.posts_locations.should be_empty
        end

        it 'returns the configured locations' do
          config.add_posts_location(location)
          config.posts_locations.should include(location)
        end
      end

      describe '#add_posts_location' do
        it 'adds the post location to the configuration' do
          config.add_posts_location(location)
          config.posts_locations.should include(location)
        end
      end
    end
  end
end
