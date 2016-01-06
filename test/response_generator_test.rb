gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/response_generator'

class ResponseGeneratorTest < Minitest::Test

  def test_responds_to_Hello_World_requests
     response_generator = ResponseGenerator.new
     request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36", "Postman-Token: 702439e0-3d1a-6d18-811f-1355b00cf279", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
     counter = 1

     output = "<html><head></head><body>HELLO WORLD(1)</body></html>"

    assert_equal output, response_generator.iterator0_result(request, counter)
  end

  def test_correctly_parses_verb
    # skip
    response_generator = ResponseGenerator.new
    request = ["GET/ HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36", "Postman-Token: 702439e0-3d1a-6d18-811f-1355b00cf279", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]

    assert_equal "Verb: POST", response_generator.iterator1_result(request)
  end
end
