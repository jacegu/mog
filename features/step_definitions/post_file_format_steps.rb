Given /^a post file with the content:$/ do |file_content|
  file_path = File.join(Dir.tmpdir, 'cucumber_post.post.html')
  @file = File.open(file_path, 'w+'){ |f| f.puts(file_content) }
end

When /^a post is created from that file$/ do
  @post = Mog::Post.from_formatted_file(@file, Mog::PostFileFormat)
end

Then /^the post title should be "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the post description should be "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the post content should contain "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
