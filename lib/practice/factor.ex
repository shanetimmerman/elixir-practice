defmodule Practice.Factor do
  def factor(x) do
  # gets all the factors of a number 
    cond do
      # Converts a string input into an integer (one of the tests kept failing because it passed in a string)
      is_number(x) ->
        Enum.reverse(get_factors_by_2(x, []))
      is_bitstring(x) ->
        Enum.reverse(get_factors_by_2(parse_integer(x), []))
      true ->
        raise "Invalid type passed"
    end
  end

  def parse_integer(text) do
  # converts a string into an integer
    {num, _} = Integer.parse(text)
    num
  end

  def factor(0) do
  # 0 has no factors
    []
  end

  def get_factors_by_2(1, factors) do
  # If given 1, stop recurring and return the list of factors
    factors
  end

  def get_factors_by_2(num, factors) do
  # Gets alls the factosr for the given number, adds them to the accumulator, and divides the number by 2 
  # Strategy: if even, keep dividing by 0, then, factor by odds
  # this way, we can increment by 2 
    if rem(num, 2) == 0 do
      get_factors_by_2(Kernel.trunc(num / 2), [2 | factors])
    else
      get_factors_odds(num, factors, 3)
    end
  end

  def get_factors_odds(1, factors, _) do
  # If given 1, stop recurring and return the list of factors
    factors
  end

  def get_factors_odds(num, factors, curr_num) do
  # Gets all the odd factors of a number
  # if the number is divisible by the current num, then recur on the number divided by current num, 
  # adding current num to the accumulator
  # otherwise, icrement the current num by 2.
    cond do
      num / 2 < curr_num ->
      # if the num/2 is < curr_num, we know we are done factoring 
        [num | factors]
      rem(num, curr_num) == 0 ->
        get_factors_odds(Kernel.trunc(num / curr_num), [curr_num | factors], curr_num)
      true ->
        get_factors_odds(num, factors, curr_num + 2)
    end
  end
end
