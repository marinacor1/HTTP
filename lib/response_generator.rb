require 'pry'
require 'hurley'
require 'socket'

class ResponseGenerator

  def path_filter(request, counter = 0)
    if     request.join.include?("/hello")      then return hello(counter)
    elsif  request.join.include?("/datetime")   then return (datetime)
    elsif  request.join.include?("/shutdown")   then return shutdown(counter)
    elsif  request.join.include?("word_search") then return word_search(request)
    elsif  request.join.include?("GET / HTTP/") then return diagnostics(request)
    else
      request
    end
  end

  def hello(counter)
    "<html><head></head><body>HELLO WORLD(#{counter})</body></html>"
  end

  def diagnostics(request)
    binding.pry
    result = ["Verb: #{request[0].split(" ")[0]}",
    "Path: #{request[0].split(" ")[1]}",
    "Protocol: #{request[0].split(" ")[2]}",
    "#{request[1]}",
    "Port: #{request[1][-4]}#{request[1][-3]}#{request[1][-2]}#{request[1][-1]}",
    "Origin: #{request[1].split(" ")[1].split(":")[0]}", "Accept:#{request[6].split(":")[1]+request[8]+request[11].split(";")[1]}"]

  end

  def datetime
    t = Time.new
    t.strftime("%l:%M%p on %A, %B %e, %Y")
  end

  def shutdown(counter)
    "Total Requests: #{counter+=1}"
  end

  def word_search(request)
    word = request[0].split(" ")[1].split("word")[2].delete("=")

    #word = request[0].split("/")[1].split(" ")[0].split("word")[2].delete("=")

    words = {}
    File.open("/usr/share/dict/words") do |file|
       file.each do |line|
        words[line.strip] = true
      end
    end

    if words[word] == true
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end

  end
end
