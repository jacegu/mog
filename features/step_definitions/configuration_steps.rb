Given /^I configure a new option with its value$/ do
  @option = :the_option_name_i_just_made_up
  @value = 'the option value'
  @configuration = Mog::Configuration.new
  @configuration.set @option, @value
end

When /^I ask the configuration for the option$/ do
  @configured_value = @configuration.configured_value_for(@option)
end

Then /^I get the cofigured value$/ do
  @configured_value.should == @value
end
