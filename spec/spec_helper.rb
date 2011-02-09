$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'
require 'digest/md5'
require 'ucallback'

RSpec.configure do |config|
  config.mock_with :rspec
end