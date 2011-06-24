$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'lib')

require 'tmpdir'
require 'capybara/cucumber'
require 'mog'

Capybara.app = Mog::Engine
