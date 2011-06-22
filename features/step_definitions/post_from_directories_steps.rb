TEMPORAL_DIR = Dir.tmpdir

def create_file_at_temporal_dir(name, content)
  file_path = File.join(TEMPORAL_DIR, name)
  File.open(file_path, 'w+'){ |f| f.puts content }
end

Given /^I have a published post in the post directory$/ do
  @post = Mog::Post.new('title', 'description', 'content', DateTime.parse('2011-05-08 10:00'))
  create_file_at_temporal_dir 'cucumber_post.post.html',
    "#{@post.publication_time}\n#{@post.title}\n#{@post.description}\n#{@post.content}"
end

Given /^there is a file that is not a post in the directory$/ do
  create_file_at_temporal_dir 'not_a_post.html', 'this is no t a post file'
end

When /^I configure the blog with that directory$/ do
  config = Mog::Configuration.new
  config.set(:locations, [dir(TEMPORAL_DIR)])
  @blog = Mog::Blog.new(config)
end

Then /^the post should appear in the blog$/ do
  @blog.posts.should include(@post)
end

Then /^the blog should have only ([^"]*) post$/ do |expected_number_of_posts|
  @blog.posts.count.should == expected_number_of_posts.to_i
end
