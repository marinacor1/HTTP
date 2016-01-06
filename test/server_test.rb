gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require_relative '../lib/server'

class ServerTest < Minitest::Test

  def test_server_have_connection
    client = Hurley::Client.new "http://127.0.0.1:9292/"
    assert client.connection
  end
end
