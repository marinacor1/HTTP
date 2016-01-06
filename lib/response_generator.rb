require 'pry'

class ResponseGenerator


  def iterator0_result(request, counter = 0)
    if request.join.split[1] == "/hello" then return hello(counter)
    else return diagnostics(request)
    end
  end

  def hello(counter)
    "<html><head></head><body>HELLO WORLD(#{counter})</body></html>"
  end

  def diagnostics(request)
    result = ["Verb: #{request[0].split(" ")[0]}"/n,
    "Path: #{request[0].split(" ")[1]}",
    "Protocol: #{request[0].split(" ")[2]}",
    "#{request[1]}",
    "Port: #{request[1][-4]}#{request[1][-3]}#{request[1][-2]}#{request[1][-1]}",
    "Origin: #{request[1].split(" ")[1].split(":")[0]}"]

    binding.pry



   #.chomp deletes backslash


  end

end
  # puts "Got this request:"
# puts request_lines.inspect
#
# puts "Sending response."
# response = "<pre>" + request_lines.join("\n") + "</pre>"
# output = "<html><head></head><body>HELLO WORLD(#{@counter})    ==   #{response}</body></html>"
# headers = ["http/1.1 200 ok",
#           "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#           "server: ruby",
#           "content-type: text/html; charset=iso-8859-1",
#           "content-length: #{output.length}\r\n\r\n"].join("\r\n")
