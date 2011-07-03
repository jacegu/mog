module FileSystemHelper
  TEMPORAL_DIR = Dir.tmpdir

  def create_file_at_temporal_dir(name, content)
    file_path = File.join(TEMPORAL_DIR, name)
    File.open(file_path, 'w+'){ |f| f.puts content }
  end

  def remove_posts_from_temporal_dir
    Dir.open(TEMPORAL_DIR) do |d|
      d.entries.grep(/.+\.post\..+$/).each do |e|
        File.delete(File.join(TEMPORAL_DIR,e)) unless File.directory?(e)
      end
    end
  end
end

World(FileSystemHelper)
