gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require_relative '../lib/request_filter'

class RequestFilterTest < Minitest::Test

  def test_correctly_parses_verb
    filtered_request = RequestFilter.new
    request = ["POST / HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: bf55936b-ce9d-de04-b68f-c886ffcd2f40",
               "Accept: */*",
               "DNT: 1",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]
    filtered_request.parse(request)
    assert_equal "Verb: POST", filtered_request.diagnostic_result[0]
  end

  def test_correctly_parses_through_request
    filtered_request = RequestFilter.new
    request = ["POST / HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: bf55936b-ce9d-de04-b68f-c886ffcd2f40",
               "Accept: */*",
               "DNT: 1",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]
    filtered_request.parse(request)
    assert_equal "Verb: POST", filtered_request.diagnostic_result[0]
    assert_equal "Path: /", filtered_request.diagnostic_result[1]
    assert_equal "Protocol: HTTP/1.1", filtered_request.diagnostic_result[2]
    assert_equal "Host: 127.0.0.1:9292", filtered_request.diagnostic_result[3]
    assert_equal "Port: 9292", filtered_request.diagnostic_result[4]
    assert_equal "Origin: 127.0.0.1", filtered_request.diagnostic_result[5]
    assert_equal "Accept: */*", filtered_request.diagnostic_result[6]
  end

  def test_responds_to_Hello_World_requests
    skip
     response_generator = ResponseGenerator.new
     filtered_request = RequestFilter.new

     request = ["GET /hello HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Cache-Control: no-cache",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 2ce77957-f9bc-d829-5c52-52b4dabe0864",
               "Accept: */*",
               "DNT: 1",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]
     counter = 0

    assert_equal "HELLO WORLD(#{counter})", filtered_request.path_filter(request)
  end
end
