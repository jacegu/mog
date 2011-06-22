Given /^I configure a new option with its value$/ do
  @configuration = Mog::Configuration.new
  @option = :the_option_name_i_just_made_up
  @value = 'the option value'
  @configuration.set @option, @value
end

Given /^I configure an option with the name "([^"]*)" and the value "([^"]*)"$/ do |option, value|
  @configuration = Mog::Configuration.new
  @option = option.to_sym
  @value =  value
  @configuration.set @option, @value
end

Given /^I have configured some locations$/ do
  @location = dir(TEMPORAL_DIR)
  @configuration = Mog::Configuration.new
  @configuration.add_posts_location @location
end

When /^I ask the configuration for the option$/ do
  @configured_value = @configuration.configured_value_for(@option)
end

When /^I create a blog with that configuration$/ do
  @blog = Mog::Blog.new(@configuration)
end

When /^I ask the configuration for posts locations$/ do
  @locations = @configuration.posts_locations
end

Then /^I get the cofigured value$/ do
  @configured_value.should == @value
end

Then /^the blog takes its posts from the configured locations$/ do
  @blog.posts_locations.should == [@location]
end

Then /^I should be able to access that option as a blog method$/ do
  @blog.the_option_name_i_just_made_up.should == @value
end

Then /^I should be able to access that option as a blog method named "([^"]*)"$/ do |method_name|
  @blog.send(method_name).should == @value
end
Then /^I get the configured locations$/ do
  @locations.should == [@location]
end
