Given /^a post file with the content:$/ do |file_content|
  file_path = File.join(Dir.tmpdir, 'cucumber_post.post.html')
  file = File.open(file_path, 'w+'){ |f| f.puts(file_content) }
  @post_file = Mog::PostFile.new(file_path)
end

When /^a post is created from that file$/ do
  @post = Mog::Post.from_post_file(@post_file)
end

Then /^the post title should be "([^"]*)"$/ do |expected_title|
  @post.title.should == expected_title
end

Then /^the post description should be "([^"]*)"$/ do |expected_description|
  @post.description.should == expected_description
end

Then /^the post content should contain "([^"]*)"$/ do |expected_content|
  @post.content.should match(expected_content)
end
