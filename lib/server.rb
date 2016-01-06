  require 'socket'
tcp_server = TCPServer.new(9292)
counter = 0
loop do
  counter += 1
  client = tcp_server.accept

  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end


  client.puts headers
  client.puts output

  client.close
end
