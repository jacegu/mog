Given /^a post file with the content:$/ do |file_content|
  @file_path = File.join(Dir.tmpdir, 'cucumber_post.post.html')
  File.open(@file_path, 'w+'){ |f| f.puts(file_content) }
end

When /^a post is created from that file$/ do
  File.open(@file_path, 'r+'){ |f| @post = Mog::PostFile.new(f) }
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
