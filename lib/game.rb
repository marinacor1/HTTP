class Game
 attr_reader :value, :output, :counter
 attr_accessor :guess_count, :last_guess

  def initialize(request, counter, last_guess)
    if last_guess == nil
      @value = rand(100)
      redirect(request)
    else
      @value = last_guess
      redirect(request)
    end
  end

  def redirect(request)
    guess = (request[0].split("=")[1].split(" ")[0]).to_i
    if guess > @value
      @ouput = "Your guess is too high; try again."
    elsif guess < @value
      @output =  "Your guess is too low; try again."
    else
      @output = "You got it right! Way to go!"
    end
  end

end
