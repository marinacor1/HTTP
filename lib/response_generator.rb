require 'pry'
require 'hurley'
require 'socket'
require_relative 'game'

class ResponseGenerator

  attr_reader :response_code, :diagnostic_result
  attr_accessor :output


  def path_filter(request, counter = 0)
    if     request.join.include? ("/hello")
       hello(counter)
    elsif  request.join.include?("/datetime")
       (datetime)
    elsif  request.join.include?("/shutdown")
       shutdown(counter)
    elsif  request.join.include?("word_search?")
      word_search(request)
    elsif  request.join.include?("/start_game")
       start_game
    elsif  request.join.include?("/game?")
       guessing_game(request, counter)
     else
       ""
    end
  end

  def hello(counter)
    "HELLO WORLD(#{counter})"
  end

  def parse(request)
    @verb = request[0].split(" ")[0]
    @path = request[0].split(" ")[1]
    @protocol = request[0].split(" ")[2]
    @host = request[1]
    @port = request[1][-4]+request[1][-3]+request[1][-2]+request[1][-1]
    @origin = request[1].split(" ")[1].split(":")[0]
    request.map do |line|
      if line.include?("Accept:")
        @accept = line.split(":")[1]
      end
    end
    @diagnostic_result = ["Verb: #{@verb}",
    "Path: #{@path}",
    "Protocol: #{@protocol}", "#{@host}",
    "Port: #{@port}",
    "Origin: #{@origin}", "Accept:#{@accept}"]
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
    "Good Luck!"
  end


  def guessing_game(request, counter)
    if @game_counter == nil
      "Need to start a new game first"
    elsif @last_guess == nil
      game_output = Game.new(request, counter, last_guess = "")
      game_output.output
      @last_guess = game_output.value
      @game_counter += 1
      "#{game_output}\nYour guess count is: #{@game_counter}"
    else
      # binding.pry
      game_output = Game.new(request, counter, @last_guess)
      game_output.output
      @last_guess = game_output.value
      @game_counter += 1
      "#{game_output}\nYour guess count is: #{@game_counter}"
    end
  end
end
