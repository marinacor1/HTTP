require 'Hurley'
require 'Socket'

#request
GET / HTTP/1.1
Host: 127.0.0.1:9292
Connection: keep-alive
Cache-Control: max-age=0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8

#response
http/1.1 200 ok
date: Sun,  1 Nov 2015 17:25:48 -0700
server: ruby
content-type: text/html; charset=iso-8859-1
content-length: 27

The response body goes here


#goal
<pre>
Verb: POST
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
</pre>

client = Hurley::Client.new "localhost:9292"

require 'socket'
tcp_server = TCPServer.new(9292)
@counter = 0
loop do
  @counter += 1
  client = tcp_server.accept

  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got this request:"
  puts request_lines.inspect

  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "</pre>"
  output = "<html><head></head><body>HELLO WORLD(#{@counter})    ==   #{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output

  # puts ["Wrote this response:", headers, output].join("\n")
  client.close
end
puts "\nResponse complete, exiting."
puts "<pre"
puts "Host: #{client.host}"
puts "Port: #{client.port}"


puts "</pre>"
