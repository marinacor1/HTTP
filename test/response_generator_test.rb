gem 'minitest', '~> 5.2'
require 'pry'
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

     output = "<html><head></head><body>HELLO WORLD(#{counter})</body></html>"

    assert_equal output, response_generator.path_filter(request, counter)
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

    assert_equal "Verb: POST", response_generator.path_filter(request)[0]
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
              #  binding.pry
    assert_equal "Verb: POST", response_generator.path_filter(request)[0]
    assert_equal "Path: /", response_generator.path_filter(request)[1]
    assert_equal "Protocol: HTTP/1.1", response_generator.path_filter(request)[2]
    assert_equal "Host: 127.0.0.1:9292", response_generator.path_filter(request)[3]
    assert_equal "Port: 9292", response_generator.path_filter(request)[4]
    assert_equal "Origin: 127.0.0.1", response_generator.path_filter(request)[5]
    assert_equal "Accept: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36Accept: */*q=0.8", response_generator.path_filter(request)[6]
  end

  def test_returns_date_and_time_when_called
    # skip
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

    assert_equal t.strftime("%l:%M%p on %A, %B %e, %Y"), response_generator.path_filter(request)
  end

  def test_returns_shutdown_and_counter_when_called
    # skip
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

    assert_equal "Total Requests: 1", response_generator.path_filter(request)
  end

  def test_word_search_gives_appropriate_message_for_known_word
    # skip
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

       word = "coffee"
       assert_equal "coffee is a known word", response_generator.path_filter(request)
  end

  def test_word_search_gives_appropriate_message_for_unknown_word
    # skip
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

       word = "kerrw"
       assert_equal "kerrw is not a known word", response_generator.path_filter(request)
  end

  def test_guessing_game_prints_Good_Luck_at_initiation
    skip
    response_generator = ResponseGenerator.new
    request = ["POST / to/start_game",
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

    assert_equal "Good Luck!", response_generator.path_filter(request)
  end

  def test_gives_number_of_guesses_only_if_over_0
    skip
    response_generator = ResponseGenerator.new
    request = ["GET / to/game",
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
    counter = 0
    assert_equal nil,
     response_generator.path_filter(request).num
     counter = 1
     assert_equal 1,
      response_generator.path_filter(request).num
  end

  def test_correctly_outputs_if_guess_too_high
     skip
    response_generator = ResponseGenerator.new
    request = ["GET / to/game",
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
    correct_number = 7
    guess = 49
    assert_equal "Your guess is too high; try again.",       response_generator.path_filter(request).output

  end

end
