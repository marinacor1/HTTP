gem 'minitest', '~> 5.2'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require_relative '../lib/game'
require_relative '../lib/response_generator'
require_relative '../lib/request_filter'

class GameTest < Minitest::Test

  def test_guessing_game_prints_Good_Luck_at_initiation
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
    last_guess = nil
    assert_equal "Good Luck!", response_generator.start_game
  end

  def test_makes_you_start_new_game
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
     assert_equal "Need to start a new game first",
      response_generator.guessing_game(request, counter)
  end
  def test_gives_number_of_guesses
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
     counter = 1
     last_guess = 13

     assert_equal 1,
      response_generator.game_counter
  end

  def test_correctly_outputs_if_guess_too_high
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
    @value = 7
    counter = 1
    last_guess = 49
    new_game = Game.new(request, counter, last_guess)

    assert_equal "Your guess is too high; try again.",       new_game.output

  end

  def test_correctly_outputs_if_guess_too_low
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
   @value = 7
   counter = 1
   last_guess = 49
   new_game = Game.new(request, counter, last_guess)

    assert_equal "Your guess is too low; try again.",       new_game.output
  end

  def test_correctly_outputs_if_guess_correct
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
    @value = 7
    counter = 1
    last_guess = 49
    new_game = Game.new(request, counter, last_guess)
    assert_equal "You got it right! Way to go!",       new_game.output
  end

end
