require 'rake'
require 'rspec/core/rake_task'

desc 'Launch mog'
task :run do
  default_port = '4567'
  port = ENV['port']
  port ||= default_port
  `shotgun -p #{port}`
end

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end
