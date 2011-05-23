module Mog
  describe PostFile do
    let(:publication_time){ DateTime.parse('2011-01-01 12:00:00+00:00') }
    let(:the_file_content){ %{ #{publication_time}\n
                               title\n
                               \ndescription\n
                               first content line\n
                               second content line} }

    let(:the_file_path){ 'path/to/the/file.post.html' }

    before(:each) do
      the_file = double(:file)
      the_file.should_receive(:read).and_return(the_file_content)
      @post_file = PostFile.new(the_file)
    end

    describe '#new' do
      it 'reads the content of the given file' do
        @post_file.source_file_content.should == the_file_content
      end
    end

    describe '#publication_time' do
      it 'returns the first line with text of the file content' do
        @post_file.publication_time.should == publication_time
      end
    end

    describe '#title' do
      it 'returns the second line with text of the file content' do
        @post_file.title.should == 'title'
      end
    end

    describe '#description' do
      xit 'returns the third line with text of the file content' do
        @post_file.description.should == 'description'
      end
    end

    describe '#content' do
      xit 'returns every line from the fourth to the last' do
        @post_file.content.should == "first content line\nsecond content line"
      end
    end

    xit 'is equal to a post with the same title, description, content and publication time' do
      the_post = Post.new('title', 'description', "content line\nsecond content line")
      @post_file.should be_equal(the_post)
    end
  end
end
