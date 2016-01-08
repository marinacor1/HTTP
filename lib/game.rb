class Game
    attr_reader :value, :output, :counter
    attr_accessor :guess_count, :last_guess

  def initialize(request, counter, last_guess)
    if last_guess != ""
      redirect(request)
      @value = last_guess
    else
      @value = rand(100)
      redirect(request)
    end
  end

  def find_guess(request)

    #         # <form action='/start_game' method='post'>
    #         # <input type='Type Your Guess'></input>
    #         # </form>"
     #submitting the guess
     #figuring out the person's guess in the body
     redirect
  end

  def redirect(request)
    binding.pry
    guess = (request[0].split("=")[1].split(" ")[0]).to_i
    if guess > @value
      #replay game with current @value passed inou
      @ouput = "Your guess is too high; try again."
    elsif guess < @value
      #replay game with current @value passed in
      @output =  "Your guess is too low; try again."
    # elsif guess == ""
    #  @output = "Good Luck!"
   else
      #game finishes. counter reset to 0
      @output = "You got it right! Way to go!"
    end
  end

#   # POST to /start_game
# def start_game
#   @game = Game.new
#   @response = 200 ok
# end
# # GET to /game
# def game
# if @game.present?
#    @response = 200
#    @output = @game.guess_count + @game.last_work + @game.state
# else
#   @repsonse = 403
# end
# # POST to /game
# def guess(request)
#   if @game.present?
#     @Response = 200
#     @game.guess(request)
#   else
#     @resposne = 403
#   end
# end
#
# def guessing_game(request, counter = 0)
#
#   @game = Game.new unless @game
#
#     @response_conde = @game.response_code(request)
#     @output = @game.process(request)
#
#       #user submits POST to /start_game
#       guess = 4
#       @response_code = "301 Permanently Moved"
#       counter += 1
#       correct_number = rand[0..100]
#
#         Number of guesses: #{counter}"
#         # # #user submits GET to/guessing_game
#       if guess > correct_number
#         @ouput = "Your guess is too high; try again."
#         puts @output
#          #replay game with current correct_number passed in
#       elsif guess < correct_number
#         @output =  "Your guess is too low; try again."
#         puts @output
#          #replay game with current correct_number passed in
#       else
#         @output = "You got it right! Way to go!"
#         puts @output
#          #game finishes. counter reset to 0
#           correct_number = rand[0..100]
#        end
#   end

end
