gem 'minitest', '~> 5.2'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require_relative '../lib/response_generator'

class ResponseGeneratorTest < Minitest::Test

  def test_port_is_9292
    client = Hurley::Client.new "http://127.0.0.1:9292/"
    assert_equal 9292, client.port
  end

  def test_responds_to_HTTP_requests
     client = Hurley::Client.new "http://127.0.0.1:9292/"
     assert client.connection
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

    assert_equal "HELLO WORLD(#{counter})", response_generator.hello(counter)
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
    assert_equal t.strftime("%l:%M%p on %A, %B %e, %Y"), response_generator.datetime
  end

  def test_returns_counter_when_called
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

    assert_equal "Total Requests: 0", response_generator.shutdown(counter)
  end

  def test_word_search_gives_appropriate_message_for_known_word
    response_generator = ResponseGenerator.new

    request = ["GET /word_search?word=coffee HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Cache-Control: no-cache",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: db8775b9-67e3-d5ed-d66a-58661ad1c420",
               "Accept: */*",
               "DNT: 1",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

       assert_equal "Coffee is a known word.", response_generator.word_search(request)
  end

  def test_word_search_gives_appropriate_message_for_unknown_word
    response_generator = ResponseGenerator.new

     request = ["GET /word_search?word=kerrw HTTP/1.1",
                 "Host: 127.0.0.1:9292",
                 "Connection: keep-alive",
                 "Cache-Control: no-cache",
                 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
                 "Postman-Token: db8775b9-67e3-d5ed-d66a-58661ad1c420",
                 "Accept: */*",
                 "DNT: 1",
                 "Accept-Encoding: gzip, deflate, sdch",
                 "Accept-Language: en-US,en;q=0.8"]

       assert_equal "Kerrw is not a known word.", response_generator.word_search(request)
  end

end
