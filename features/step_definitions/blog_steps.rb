Given /^I have published a post$/ do

  Mog::Engine.configure do |config|
    config.set :blog_name,        ''
    config.set :blog_description, ''
    config.set :blog_view_markup, 'erb'
    config.add_posts_location  dir(TEMPORAL_DIR)
  end

  @the_title       = 'a post created for testing purposes'
  @the_description = 'a post created for testing purposes is the description'
  @the_content     = 'a post created for testing purposes is the content'

  post_content = "#{DateTime.now}\n#{@the_title}\n#{@the_description}\n#{@the_content}"
  create_file_at_temporal_dir('a-post.post.html', post_content)
end

When /^I visit that post's page$/ do
  visit '/blog/a-post-created-for-testing-purposes'
end

Then /^I should see the published post$/ do
  page.should have_content(@the_title)
  #page.should have_content(@the_description)
  page.should have_content(@the_content)
end
