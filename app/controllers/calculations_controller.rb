class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length-@text.count(' ')

    @word_count = @text.count(' ')+1

    @occurrences = @text.scan(/#{@special_word}/).count
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

        i= @apr/12/100
        y=@years*12
        p=@principal

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (p*i)/(1-(1+i)**-y)
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days =  @hours/24
    @weeks = @days/7
    @years = @weeks/52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort
    @count = @numbers.count
    @minimum = @numbers.min
    @maximum = @numbers.max
    @range = @maximum-@minimum
    @median = (@sorted_numbers[(@count-1)/2]+@sorted_numbers[@count/2])/2
    @sum = @numbers.sum
    @mean = @sum/@count
    @variance = (@numbers.inject(0){|sum,x|sum + (x-@mean)**2})/@count
    @standard_deviation = @variance**(0.5)
    mode_temp= @numbers.inject({}) { |k, v| k[v] = @numbers.count(v); k }
    @mode =mode_temp.select { |k,v| v == mode_temp.values.max }.keys
  end
end
