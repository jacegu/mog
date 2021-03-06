$: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')

require 'mog'

Mog::Engine.configure do |config|
  config.set :blog_name,        'mog - the minimalistic blog engine'
  config.set :blog_author,      'Javier Acero'
  config.set :blog_description, 'This blog was generated with the mog blog engineo'
  config.set :blog_view_markup, 'erb'
  config.set :blog_posts_per_page, 1

  config.add_posts_location  dir('_posts')
end

run Mog::Engine
