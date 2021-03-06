require 'socket'
require 'pry'
require_relative 'request_filter'

class ServerConnector

  filtered_request = RequestFilter.new
  counter = 0
  tcp_server = TCPServer.new(9292)


      loop do
        client = tcp_server.accept

        puts "Ready for a request"
        request_lines = []
        while line = client.gets and !line.chomp.empty?
          request_lines << line.chomp
        end

        puts "Got this request:"
        puts request_lines.inspect

        if request_lines.join.include?("/favicon.ico")
          counter -= 1
        end

        filtered_request.parse(request_lines)
        filtered_response = filtered_request.path_filter(request_lines, counter)



        puts "Sending response."
        response = "<pre>" + filtered_response + "</pre> <pre>" + filtered_request.diagnostic_result.join("\n") + " </pre>"
        output = "<html><head></head><body>#{response}</body></html>"

        headers = ["http/1.1 #{@response_code}",
                  "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                  "server: ruby",
                  "content-type: text/html; charset=iso-8859-1",
                  "content-length: #{output.length}\r\n\r\n"].join("\r\n")
        client.puts headers
        client.puts output

        puts ["Wrote this response:", headers, output].join("\n")
        counter += 1

        if output.include? "Total Requests:"
          tcp_server.close
        end

        client.close
        puts "\nResponse complete, ready for next request."

    end


    end
