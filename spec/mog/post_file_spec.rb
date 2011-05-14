module Mog
  describe PostFile do
    let(:the_file_content) { " \ntitle\n \ndescription\nfirst content line\nsecond content line" }
    let(:the_file_path){ 'path/to/the/file.post.html' }

    before(:each) do
      the_opened_file = double(:opened_file)
      the_opened_file.should_receive(:read).and_return(the_file_content)
      File.stub(:open).with(the_file_path, 'r').and_yield(the_opened_file)
      @post_file = PostFile.new(the_file_path)
    end

    describe '#new' do
      it 'reads the content of the file at the given path' do
        @post_file.source_file_content.should == the_file_content
      end
    end

    describe '#title' do
      it 'returns the first line with text of the file content' do
        @post_file.title.should == 'title'
      end
    end

    describe '#description' do
      it 'returns the second line with text of the file content' do
        @post_file.description.should == 'description'
      end
    end

    describe '#content' do
      it 'returns every line from the third to the last' do
        @post_file.content.should == "first content line\nsecond content line"
      end
    end
  end
end
