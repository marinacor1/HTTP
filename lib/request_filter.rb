require 'hurley'
require 'socket'
require 'pry'
require_relative 'response_generator'


class RequestFilter

  attr_reader :diagnostic_result

  def initialize
    @server_response = ResponseGenerator.new
  end

  def path_filter(request, counter = 0)
    if request.join.include? ("/hello")
       @server_response.hello(counter)
    elsif request.join.include?("/datetime")
       @server_response.datetime
    elsif request.join.include?("/shutdown")
       @server_response.shutdown(counter)
    elsif request.join.include?("word_search?")
      @server_response.word_search(request)
    elsif request.join.include?("/start_game")
       @server_response.start_game
    elsif request.join.include?("/game?")
       @server_response.guessing_game(request, counter)
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

  def diagnostic_result
    ["Verb: #{@verb}",
    "Path: #{@path}",
    "Protocol: #{@protocol}",
    "#{@host}",
    "Port: #{@port}",
    "Origin: #{@origin}", "Accept:#{@accept}"]
  end

end
