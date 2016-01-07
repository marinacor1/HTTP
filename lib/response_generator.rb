require 'pry'
require 'hurley'
require 'socket'

class ResponseGenerator

  attr_accessor :output

  def path_filter(request, counter = 0)
    request.join
    if     for_path(request, "/hello")      then return hello(counter)
    elsif  request.join.include?("/datetime")   then return (datetime)
    elsif  request.join.include?("/shutdown")   then return shutdown(counter)
    elsif  request.join.include?("word_search") then return word_search(request)
    elsif  request.join.include?("/start_game") then return guessing_game(request, counter)
    # elsif  request.join.include?("GET / HTTP/") then return diagnostics(request)
    else
      diagnostics(request)
    end
  end

  def for_path(request,path)
    request.join.include?(path)
  end

  def hello(counter)
    "HELLO WORLD(#{counter})"
  end

  def diagnostics(request)
    # binding.pry
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

  def word_search(request)
    word = request[0].split(" ")[1].split("word")[2].delete("=")
    if File.read("/usr/share/dict/words").include?("#{word}")
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end


  def guessing_game(request, counter = 0)
    #user submits POST to /start_game
    counter += 1
    num = "Number of guesses: #{counter}"

    "Good Luck!
    Number of guesses: #{counter}
    <form action='/start_game' method='post'>
    <input type='Type Your Guess'></input>
    </form>"
    # #guess = pulls from response
    #  difference = guess <=> correct_number
    # # #user submits GET to/guessing_game
    #
    #      correct_number = rand[0..100]
    # #
    #   if difference > 0
    #     @ouput = "Your guess is too high; try again."
    #     puts @output
    # #     #replay game with current correct_number passed in
    #   elsif difference < 0
    #     @output =  "Your guess is too low; try again."
    #     puts @output
    # #     #replay game with current correct_number passed in
    #   else
    #     @output = "You got it right! Way to go!"
    #     puts @output
    # #     #end game. counter reset to 0
    #     counter = 0
    #   end

  end

end
