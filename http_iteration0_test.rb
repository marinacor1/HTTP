gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'http_iteration0'

class HTTP0Test < Minitest::Test

  def test_port_is_9292
    hello = HTTP0.new
    hello_1 = HTTP0.new
    assert_equal false, hello.count == hello_1.count
  end

  def test_responds_to_HTTP_requests
    hello = HTTP0.new

  end

  def test_response_is_in_HTML_response
    hello = HTTP0.new

  end

  def test_count_increments

  end

end
