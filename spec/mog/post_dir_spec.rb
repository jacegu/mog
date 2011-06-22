require 'spec_helper'

module Mog
  describe PostDir do
    let(:dir){ double :opened_directory }
    let(:path){ '/path/to/the/directory' }

    before do
      dir.stub(:path).and_return(path)
    end

    it 'has a path' do
      PostDir.new(dir).path.should == path
    end

    describe '::from directory' do
      it 'creates a post directory from the opened directory' do
        PostDir.should_receive(:new).with(dir)
        PostDir.from(dir)
      end
    end

    describe '::at path' do
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

    context 'working with its content' do
      let(:a_file_entry){ 'not_a_post.html' }
      let(:full_path_to_file_entry){ File.join(path, a_file_entry) }
      let(:a_post_file_entry){ 'post-file.post.html' }
      let(:full_path_to_post_file_entry){ File.join(path, a_post_file_entry) }
      let(:a_dir_entry){ 'dir_named_like_a.post.html' }
      let(:full_path_to_dir_entry){ File.join(path, a_dir_entry) }

      before do
        File.stub(:file?).with(full_path_to_file_entry).and_return(true)
        File.stub(:file?).with(full_path_to_post_file_entry).and_return(true)
        File.stub(:file?).with(full_path_to_dir_entry).and_return(false)
        dir.stub(:entries).and_return([a_post_file_entry, a_dir_entry, a_file_entry])
        @dir = PostDir.from(dir)
      end

      describe '#entries' do
        it 'returns the entries of the directory with their absolute path' do
          @dir.entries.should
            include(full_path_to_file_entry, full_path_to_post_file_entry, full_path_to_dir_entry)
        end
      end

      describe '#post_file_entries' do
        it 'returns the entries whose name matches the post file name pattern' do
          @dir.post_file_entries.should include(full_path_to_post_file_entry)
        end

        it 'only returns entries that are files' do
          @dir.post_file_entries.should_not include(full_path_to_dir_entry)
        end
      end

      describe '#post' do
        let(:the_file){ double(:file) }
        let(:the_post_file){ double(:post_file) }

        before do
          File.should_receive(:open).with(full_path_to_post_file_entry).and_return(the_file)
          PostFile.should_receive(:from).with(the_file).and_return(the_post_file)
        end

        it 'returns post for each post file in it' do
          @dir.posts.should == [the_post_file]
        end

        it 'does not create posts from directories' do
          File.should_not_receive(:open).with(full_path_to_dir_entry)
          @dir.posts
        end

        it 'does not create posts from files that are not posts' do
          File.should_not_receive(:open).with(full_path_to_file_entry)
          @dir.posts
        end
      end
    end

  end
end
