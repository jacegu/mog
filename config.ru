$: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')

require 'mog'

Mog::Engine.configure do |config|
  config.set :name,   'mog - the minimalistic blog engine'
  config.set :author, 'Javier Acero'
end

run Mog::Engine
