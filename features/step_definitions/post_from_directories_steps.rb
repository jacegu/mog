Given /^I have a published post in the post directory$/ do
  @post = Mog::Post.new('title', 'description', 'content', DateTime.parse('2011-05-08 10:00'))
  @dir_path = Dir.tmpdir
  file_path = File.join(Dir.tmpdir, 'cucumber_post.post.html')
  File.open(file_path, 'w+') do |f|
    f.puts "#{@post.publication_time}\n#{@post.title}\n#{@post.description}\n#{@post.content}"
  end
end

When /^I configure the blog with that directory$/ do
  dir = Dir.open(@dir_path)
  post_directory = Mog::PostDir.from(dir)
  config = Mog::Configuration.new
  config.set(:locations, [post_directory])
  @blog = Mog::Blog.new(config)
end

Then /^the blog should appear in the blog$/ do
  @blog.posts.should include(@post)
end
