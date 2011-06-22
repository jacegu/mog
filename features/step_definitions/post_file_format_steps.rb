Given /^a post file with the content:$/ do |file_content|
  file_name = 'cucumber_post.post.html'
  @file_path = File.join(TEMPORAL_DIR, file_name)
  create_file_at_temporal_dir file_name, file_content
end

When /^a post is created from that file$/ do
  File.open(@file_path, 'r+'){ |f| @post = Mog::PostFile.from(f) }
end

Then /^the post should be published on "([^"]*)"$/ do |expected_publication_time|
  @post.publication_time.should == DateTime.parse(expected_publication_time)
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

Then /^the post should not be published$/ do
  @post.published?.should be_false
end

