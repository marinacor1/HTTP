require 'socket'
require_relative 'response_generator'
require 'pry'

class ServerConnector
  response_generator = ResponseGenerator.new

  tcp_server = TCPServer.new(9292)
  counter = 0

  loop do
    client = tcp_server.accept
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    output = response_generator.iterator0_result(request_lines, counter)

    client.puts output
    client.close
    counter += 1
  end

end
