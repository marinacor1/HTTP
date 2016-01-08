require 'pry'
require 'hurley'
require 'socket'

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
    elsif  request.join.include?("word_search")
      word_search(request)
    elsif  request.join.include?("/start_game")
       guessing_game(request, counter)
     else
       ""
    end
  end

  def hello(counter)
    "HELLO WORLD(#{counter})"
  end

  def parse(request)
    binding.pry
    @verb = request[0].split(" ")[0]
    @path = request[0].split(" ")[1]
    @protocol = request[0].split(" ")[2]
    @host = request[1]
    @port = request[1][-4]
    # request[1][-3]request[1][-2]}request[1][-1]
    @origin = request[1].split(" ")[1].split(":")[0]
    @accept = request[6].split(":")[1]
    # request[8]request[11].split(";")[1]
    @diagnostic_result = ["Verb: #{@verb}",
    "Path: #{@path}",
    "Protocol: #{@protocol}", "#{@host}",
    "Port:  #{@port}",
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

  def guessing_game(request, counter = 0)
  end
end
