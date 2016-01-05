#Let's start our server instance and have it listen on port 9292
require 'socket'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept
#We can read the request from the client object which is what we call an IO stream
@count = 0
loop do

  @count += 1
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

    puts "Got this request:"
    puts request_lines.inspect


  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "</pre>"
  output = "<html><head></head><body>Hello World #{@count}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output
end

puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."
