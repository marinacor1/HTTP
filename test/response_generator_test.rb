gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require_relative '../lib/response_generator'

class ResponseGeneratorTest < Minitest::Test

  def test_port_is_9292
    client = Hurley::Client.new "http://127.0.0.1:9292/"
    assert_equal 9292, client.port
  end

  def test_responds_to_HTTP_requests
    skip
     client = Hurley::Client.new "http://127.0.0.1:9292/"
     response = Hurley.get("http://127.0.0.1:9292/")
    assert client.success?
  end

  def test_response_is_in_HTML
    skip
    client = Hurley::Client.new "http://127.0.0.1:9292/"
    response = Hurley.post("http://127.0.0.1:9292/")

    assert response.body.include?("<html>")
  end

  def test_count_changes
    skip
    client = Hurley::Client.new "http://127.0.0.1:9292/"
    response = Hurley.get("http://127.0.0.1:9292/")
    response_2 = Hurley.get("http://127.0.0.1:9292/")
    refute response.body == response_2.body
  end

  def test_responds_to_Hello_World_requests
     response_generator = ResponseGenerator.new
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

     output = "<html><head></head><body>HELLO WORLD(#{counter})</body></html>"

    assert_equal output, response_generator.iterator0_result(request, counter)
  end

  def test_correctly_parses_verb
    response_generator = ResponseGenerator.new
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

    assert_equal "Verb: POST", response_generator.iterator0_result(request)[0]
  end

  def test_correctly_parses_through_request
    response_generator = ResponseGenerator.new
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

    assert_equal "Verb: POST", response_generator.iterator0_result(request)[0]
    assert_equal "Path: /", response_generator.iterator0_result(request)[1]
    assert_equal "Protocol: HTTP/1.1", response_generator.iterator0_result(request)[2]
    assert_equal "Host: 127.0.0.1:9292", response_generator.iterator0_result(request)[3]
    assert_equal "Port: 9292", response_generator.iterator0_result(request)[4]
    assert_equal "Origin: 127.0.0.1", response_generator.iterator0_result(request)[5]
    assert_equal "Accept: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36Accept: */*q=0.8", response_generator.iterator0_result(request)[6]
  end

  def test_returns_date_and_time_when_called
    response_generator = ResponseGenerator.new
    request =["GET /datetime HTTP/1.1",
             "Host: 127.0.0.1:9292",
             "Connection: keep-alive",
             "Cache-Control: no-cache",
             "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
             "Postman-Token: 6e76c48c-da8b-1fcc-adc8-64af4d017821",
             "Accept: */*",
             "DNT: 1",
             "Accept-Encoding: gzip, deflate, sdch",
             "Accept-Language: en-US,en;q=0.8"]
    t = Time.new

    assert_equal t.strftime("%l:%M%p on %A, %B %e, %Y"), response_generator.iterator0_result(request)
  end

  def test_returns_shutdown_and_counter_when_called

    #cant really test without pinging the server from test suite

    response_generator = ResponseGenerator.new
    request =  ["GET /shutdown HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Cache-Control: no-cache",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 6f3ac87b-e573-4091-a36e-5f07ebf84eb4",
               "Accept: */*",
               "DNT: 1",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]
    counter = 0

    assert_equal "Total Requests: 0", response_generator.iterator0_result(request)
  end
end
