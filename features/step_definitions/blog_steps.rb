def testing_post_published_on(publication_date)
  @the_title       = 'a post created for testing purposes'
  @the_description = 'a post created for testing purposes is the description'
  @the_content     = 'a post created for testing purposes is the content'
  "#{publication_date}\n#{@the_title}\n#{@the_description}\n#{@the_content}"
end

Given /^the blog has been configured$/ do
  Mog::Engine.configure do |config|
    config.set :blog_name,        'the blog name'
    config.set :blog_description, 'the blog description'
    config.set :blog_view_markup, 'erb'
  end
end

Given /^some post locations have been added$/ do
  Mog::Engine.configure do |config|
    config.add_posts_location  dir(TEMPORAL_DIR)
  end
end

Given /^I have published a post$/ do
  post_content = testing_post_published_on(DateTime.now)
  create_file_at_temporal_dir('a-post.post.html', post_content)
end

Given /^I scheduled a post that has not been published yet$/ do
  post_content = testing_post_published_on(DateTime.now + 10)
  create_file_at_temporal_dir('a-post.post.html', post_content)
end

When /^I visit that post's page$/ do
  visit '/blog/a-post-created-for-testing-purposes'
end

When /^I visit an unknown post's page$/ do
  visit '/blog/this-post-does-not-exist/'
end

Then /^I should see the published post$/ do
  page.should have_content(@the_title)
  page.should have_content(@the_content)
end

Then /^I should get that page doesn't exist error$/ do
  page.driver.response.status.should == 404
  page.should have_content('404')
end
