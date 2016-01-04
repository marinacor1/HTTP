require 'socket'
#listens on port 9292
tcp_server = TCPServer.new(9292)
client = tcp_server.accept

puts "Ready for a request"
#Read the request from the client object in an IO stream. Store all requests in an array called request_lines
request_lines = []
while line = client.gets and !line.chomp.empty?
  #when program runs it'll hang on gets method waiting for request to come in
  #when message arrives gets read and stored into request_lines. prints to console
  request_lines << line.chomp
end

puts "Got this request:"
puts request_lines.inspect

#build response
puts "Sending response."
response = "<pre>" + request_lines.join("\n") + "</pre>"
output = "<html><head></head><body>Hello, World! (#{count})</body></html>"
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
client.puts headers
client.puts output

#close server
puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."
