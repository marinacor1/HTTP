require 'Hurley'
require 'Socket'
require_relative '../lib/http_iteration0'

#do we need to do a setup
#how do we get hurley testing?
class
def test_port_is_9292
  client = Hurley::Client.new "http://127.0.0.1:9292/"
  assert_equal 9292, client.port
end

def test_responds_to_HTTP_requests
  skip
  client = Hurley::Client.new "http://127.0.0.1:9292/"
  response = Hurley.get("http://127.0.0.1:9292/")

  assert response.success?
end

def test_response_is_in_HTML
  skip
  client = Hurley::Client.new "http://127.0.0.1:9292/"
  response = Hurley.get("http://127.0.0.1:9292/")

  assert response.body.include?("<html>")
end

def test_count_changes
  skip
  client = Hurley::Client.new "http://127.0.0.1:9292/"
  response = Hurley.get("http://127.0.0.1:9292/")
  response_2 = Hurley.get("http://127.0.0.1:9292/")
  refute response.body == response_2.body
end
