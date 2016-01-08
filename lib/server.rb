# require "pry"
# require 'socket'
#
# class Server
# tcp_server = TCPServer.new(9292)
# counter = 0
# loop do
#   client = tcp_server.accept
#
#   puts "Ready for a request"
#   request_lines = []
#   while line = client.gets and !line.chomp.empty?
#     request_lines << line.chomp
#   end
#
#   output = request_lines
#
#   # client.puts headers
#   client.puts output
#   puts output
#
#   client.close
#   counter += 1
# end
#
#     if __FILE__ == $0
#       ServerConnector.new.start_server
#     end
