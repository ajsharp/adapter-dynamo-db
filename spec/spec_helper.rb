$:.unshift(File.expand_path('../../lib', __FILE__))

require 'rspec'

require 'adapter-dynamo-db'
require 'yaml'

RSpec.configure do |config|
end