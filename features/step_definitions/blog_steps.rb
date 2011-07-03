def testing_post_published_on(publication_date, post_number = 1)
  title       = "post #{post_number} for testing purposes"
  description = "post #{post_number} for testing purposes description"
  content     = "post #{post_number} for testing purposes content"

  @published_posts = @published_posts || {}
  @published_posts[post_number] = Mog::Post.new(title, description, content, publication_date)

  "#{publication_date}\n#{title}\n#{description}\n#{content}"
end

Given /^the blog has been configured$/ do
  Mog::Engine.configure do |config|
    config.set :blog_name,        'the blog name'
    config.set :blog_description, 'the blog description'
    config.set :blog_view_markup, 'erb'
  end
end

Given /^some post locations have been added$/ do
  Mog::Engine.configure{ |c| c.add_posts_location dir(TEMPORAL_DIR) }
end

Given /^I have configured the blog to show ([^"]*) post per page/ do |page_count|
  Mog::Engine.configure{ |c| c.set :blog_posts_per_page, page_count }
end

Given /^I have published a post$/ do
  post_content = testing_post_published_on(DateTime.now)
  create_file_at_temporal_dir('post-1.post.html', post_content)
end

Given /^I have published ([^"]*) posts$/ do |published_post_count|
  1.upto(published_post_count.to_i) do |number|
    post_content = testing_post_published_on(DateTime.now, number)
    create_file_at_temporal_dir("post-#{number}.post.html", post_content)
  end
end

Given /^I scheduled a post that has not been published yet$/ do
  post_content = testing_post_published_on(DateTime.now + 10)
  create_file_at_temporal_dir('post-1.post.html', post_content)
end

When /^I visit the blog's main page$/ do
  visit '/blog'
end

When /^I visit the page ([^"]*)$/ do |page|
  visit "/blog/page/#{page}"
end

When /^I visit that post's page$/ do
  visit '/blog/post-1-for-testing-purposes'
end

When /^I visit an unknown post's page$/ do
  visit '/blog/this-post-does-not-exist/'
end

Then /^I should see the published post$/ do
  page.should have_content @published_posts[1].title
  page.should have_content @published_posts[1].content
end

Then /^I should see post ([^"]*)$/ do |post_number|
  puts @published_posts
  page.should have_content @published_posts[post_number.to_i].title
  page.should have_content @published_posts[post_number.to_i].content
end

Then /^I should get that page doesn't exist error$/ do
  page.driver.response.status.should == 404
  page.should have_content('404')
end
