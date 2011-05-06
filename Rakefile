desc 'Launch mog'
task :run do
  default_port = '4567'
  port = ENV['port']
  port ||= default_port
  `rackup -p #{port}`
end
