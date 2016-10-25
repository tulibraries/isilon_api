$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "isilon_api"
require 'webmock/rspec'
require 'pry'


WebMock.disable_net_connect!(allow_localhost: true)
SPEC_ROOT = File.dirname __FILE__

# Take the Default values
IsilonApi.configure {}
