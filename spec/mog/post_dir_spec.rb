require 'spec_helper'

module Mog
  describe PostDir do
    let!(:dir){ double :opened_directory }
    let(:path){ '/path/to/the/directory' }

    before do
      dir.stub(:path).and_return(path)
    end

    it 'has a path path' do
      PostDir.new(dir).path.should == path
    end

    describe '::form' do
      it 'creates a post directory from the opened directory' do
        PostDir.should_receive(:new).with(dir)
        PostDir.from(dir)
      end
    end

    describe '::at' do
      it 'opens the directory at the given path' do
        Dir.should_receive(:open).with(path)
        PostDir.at(path)
      end

      it 'creates a post directory with the opened directory' do
        the_post_dir = double :post_dir
        Dir.stub(:open).with(path).and_return(dir)
        PostDir.should_receive(:new).with(dir).and_return(the_post_dir)
        PostDir.at(path).should == the_post_dir
      end
    end

    describe '#entries' do
      it 'returns the entries of the directory with their absolute path' do
        entry = ['a-file']
        dir.stub(:entries).and_return(entry)
        full_path_to_entry = File.join(path, entry)
        PostDir.from(dir).entries.should == [full_path_to_entry]
      end
    end

    describe '#post' do
      let(:a_file_entry){ 'post-file.post.html' }
      let(:full_path_to_file_entry){ File.join(path, a_file_entry) }
      let(:a_dir_entry){ '.' }
      let(:full_path_to_dir_entry){ File.join(path, a_dir_entry) }

      before do
        File.stub(:file?).with(full_path_to_file_entry).and_return(true)
        File.stub(:file?).with(full_path_to_dir_entry).and_return(false)
        dir.stub(:entries).and_return([a_file_entry, a_dir_entry])
      end

      it 'creates a post file for each entry in it' do
        the_file = double(:file)
        File.should_receive(:open).with(full_path_to_file_entry).and_return(the_file)
        the_post_file = double(:post_file)
        PostFile.should_receive(:from).with(the_file).and_return(the_post_file)
        PostDir.from(dir).posts.should == [the_post_file]
      end

      it 'does not create posts from diretories' do
        File.should_not_receive(:open).with(full_path_to_dir_entry)
      end
    end

  end
end
