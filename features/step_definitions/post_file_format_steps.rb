Given /^a post file with the content:$/ do |file_content|
  file_path = File.join(Dir.tmpdir, 'cucumber_post.post.html')
  @file = File.open(file_path, 'w+'){ |f| f.puts(file_content) }
end

When /^a post is created from that file$/ do
  file_format = Mog::PostFileFormat.new
  @post = Mog::Post.from_formatted_file(@file, file_format)
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
