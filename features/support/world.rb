module FileSystemHelper
  TEMPORAL_DIR = Dir.tmpdir

  def create_file_at_temporal_dir(name, content)
    file_path = File.join(TEMPORAL_DIR, name)
    File.open(file_path, 'w+'){ |f| f.puts content }
  end
end

World(FileSystemHelper)
