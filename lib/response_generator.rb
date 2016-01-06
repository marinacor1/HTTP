require 'pry'
require 'hurley'

class ResponseGenerator


  def iterator0_result(request, counter = 0)
    if request.join.split[1] == "/hello" then return hello(counter)
    elsif request.join.split[1] == "/datetime" then return datetime
    elsif request.join.split[1] == "/shutdown" then return shutdown(counter)
    else return diagnostics(request)
    end
  end

  def hello(counter)
    "<html><head></head><body>HELLO WORLD(#{counter})</body></html>"
  end

  def diagnostics(request)
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
    "Total Requests: #{counter}"
  end


#ping = hurley.get



end
