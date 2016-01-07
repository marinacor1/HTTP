require 'pry'
require 'hurley'
require 'socket'

class ResponseGenerator

  attr_reader :response_code
  attr_accessor :output

  def path_filter(request, counter = 0)
    request.join
    if     for_path(request, "/hello")      then return hello(counter)
    elsif  request.join.include?("/datetime")   then return (datetime)
    elsif  request.join.include?("/shutdown")   then return shutdown(counter)
    elsif  request.join.include?("word_search") then return word_search(request)
    elsif  request.join.include?("/start_game") then return guessing_game(request, counter)
    # elsif  request.join.include?("GET / HTTP/") then return parse(request)
    else
      parse(request)
    end
  end

  def for_path(request,path)
    request.join.include?(path)
  end

  def hello(counter)
    "HELLO WORLD(#{counter})"
  end

  def parse(request)
    binding.pry
    @verb = request[0].split(" ")[0]
    @path = request[0].split(" ")[1]
    @protocol = request[0].split(" ")[2]
    # request[1]
    @port = request[1][-4]
    # request[1][-3]request[1][-2]}request[1][-1]
    @origin = request[1].split(" ")[1].split(":")[0]
    @accept = request[6].split(":")[1]
    # request[8]request[11].split(";")[1]
    result = ["Verb: #{@verb}",
    "Path: #{@path}",
    "Protocol: #{@protocol}",
    "Port:  #{@port}",
    "Origin: #{@origin}", "Accept:#{@accept}"]
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
      guess = 4
      @response_code = "301 Permanently Moved"
      counter += 1
      num = "Number of guesses: #{counter}"
      correct_number = rand[0..100]

        "Good Luck!
        Number of guesses: #{counter}"
        # <form action='/start_game' method='post'>
        # <input type='Type Your Guess'></input>
        # </form>"
        # #guess = pulls from response
        # # #user submits GET to/guessing_game
      if guess > correct_number
        @ouput = "Your guess is too high; try again."
        puts @output
         #replay game with current correct_number passed in
      elsif guess < correct_number
        @output =  "Your guess is too low; try again."
        puts @output
         #replay game with current correct_number passed in
      else
        @output = "You got it right! Way to go!"
        puts @output
         #game finishes. counter reset to 0
          correct_number = rand[0..100]
       end
  end

end
