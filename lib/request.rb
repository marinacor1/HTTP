require 'hurley'
require 'socket'
require 'pry'
require_relative 'response_generator'


class RequestFilter

  def initialize(request)
    @request = request
    response_generator = ResponseGenerator.new
  end

  attr_accessor :diagnostic_result

  def path_filter(request, counter = 0)
    if request.join.include? ("/hello")
       response_generator.hello(counter)
    elsif request.join.include?("/datetime")
       response_generator.datetime
    elsif request.join.include?("/shutdown")
       response_generator.shutdown(counter)
    elsif request.join.include?("word_search?")
      response_generator.word_search(request)
    elsif request.join.include?("/start_game")
       response_generator.start_game
    elsif request.join.include?("/game?")
       response_generator.guessing_game(request, counter)
     else
       ""
    end
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

  end



end
