gem 'minitest', '~> 5.2'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require_relative '../lib/game'
require_relative '../lib/response_generator'

class GameTest < Minitest::Test

  def test_guessing_game_prints_Good_Luck_at_initiation
    skip
    response_generator = ResponseGenerator.new
    request = ["POST /game?param=80 HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 7396d92d-bf22-a85b-6daf-2983c677dc8d",
               "Accept: */*",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]
    counter = 0
    new_game = Game.new(request, counter, last_guess)
    assert_equal "Good Luck!", new_game.start_game
  end

  def test_gives_number_of_guesses
    skip
    response_generator = ResponseGenerator.new

    new_game = Game.new(request, counter, last_guess)
    request = ["POST /game?param=80 HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 7396d92d-bf22-a85b-6daf-2983c677dc8d",
               "Accept: */*",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]
     counter = 1
     assert_equal 1,
      response_generator.path_filter(request).num
  end

  def test_correctly_outputs_if_guess_too_high
    skip
    response_generator = ResponseGenerator.new

    new_game = Game.new(request, counter, last_guess)
    request = ["POST /game?param=80 HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 7396d92d-bf22-a85b-6daf-2983c677dc8d",
               "Accept: */*",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]
    @@value = 7
    guess = 49
    assert_equal "Your guess is too high; try again.",       response_generator.path_filter(request).output

  end

  def test_correctly_outputs_if_guess_too_low
    skip
    response_generator = ResponseGenerator.new
    new_game = Game.new(request, counter, last_guess)
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
    @value = 7
    guess = 2
    assert_equal "Your guess is too low; try again.",       response_generator.path_filter(request).output
  end

  def test_correctly_outputs_if_guess_correct
    skip
    response_generator = ResponseGenerator.new
    new_game = Game.new(request, counter, last_guess)
    request = ["POST /game?param=80 HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 7396d92d-bf22-a85b-6daf-2983c677dc8d",
               "Accept: */*",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]
    # @value = 7
    guess = 7
    assert_equal "You got it right! Way to go!",       response_generator.path_filter(request).output
  end

  def test_test_that_game_takes_in_guess
    skip
    response_generator = ResponseGenerator.new
    new_game = Game.new(request, counter, last_guess)
    request = ["POST /game?param=80 HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Content-Length: 0",
               "Cache-Control: no-cache",
               "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
               "Postman-Token: 7396d92d-bf22-a85b-6daf-2983c677dc8d",
               "Accept: */*",
               "Accept-Encoding: gzip, deflate",
               "Accept-Language: en-US,en;q=0.8"]

    assert_equal "value", Game.new.guess
  end


end
