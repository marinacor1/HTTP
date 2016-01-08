require 'pry'
require 'hurley'
require 'socket'
require_relative 'game'
require_relative 'request_filter'

class ResponseGenerator

  attr_reader :response_code, :diagnostic_result
  attr_accessor :game_counter

  def hello(counter)
    "HELLO WORLD(#{counter})"
  end

  def datetime
    t = Time.new
    t.strftime("%l:%M%p on %A, %B %e, %Y")
  end

  def shutdown(counter)
    "Total Requests: #{counter}"
  end

  def word_search(request)
    word = request[0].split(" ")[1].split("word")[2].delete("=")
    if File.read("/usr/share/dict/words").include?("#{word}")
      "#{word.capitalize} is a known word."
    else
      "#{word.capitalize} is not a known word."
    end
  end

  def start_game
    @game_counter = 0
    @last_guess = nil
    "Good Luck!"
  end

  def guessing_game(request, counter)
    if @game_counter == nil
      "Need to start a new game first"
    elsif last_guess == nil
      game_output = Game.new(request, counter, last_guess = nil)
      @game_response = game_output.output
      @last_guess = game_output.value
      @game_counter += 1
      "#{@game_response} and your guess count is: #{@game_counter}"
    else
      game_output = Game.new(request, counter, @last_guess)
      @game_response = game_output.output
      @last_guess = game_output.value
      @game_counter += 1
      "#{@game_response} and your guess count is: #{@game_counter}"
    end
  end

end
