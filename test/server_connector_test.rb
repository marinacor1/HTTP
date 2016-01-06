gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require_relative '../lib/response_generator'

class ServerConnectorTest < Minitest::Test
  client = Hurley::Client.new "http://127.0.0.1:9292/"
  assert_equal "127.0.0.1:9292/", client.host
end
