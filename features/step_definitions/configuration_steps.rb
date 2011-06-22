Given /^I configure a new option with its value$/ do
  @option = :the_option_name_i_just_made_up
  @value = 'the option value'
  @configuration = Mog::Configuration.new
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

Then /^I get the cofigured value$/ do
  @configured_value.should == @value
end

Then /^the blog takes its posts from the configured locations$/ do
  @blog.posts_locations.should == [@location]
end

Then /^I should be able to access that option as a blog method$/ do
  expect{ @blog.the_option_name_i_just_made_up }.not_to raise_error
end
