defmodule Practice.Factor do
  def factor(x) do
    cond do
      is_number(x) ->
        Enum.reverse(get_factors_by_2(x, []))
      is_bitstring(x) ->
        Enum.reverse(get_factors_by_2(parse_integer(x), []))
      true ->
        raise "Invalid type passed"
    end
  end

  def parse_integer(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def factor(0) do
    []
  end

  def get_factors_by_2(1, factors) do
    factors
  end

  def get_factors_by_2(num, factors) do
    if rem(num, 2) == 0 do
      get_factors_by_2(Kernel.trunc(num / 2), [2 | factors])
    else
      get_factors_odds(num, factors, 3)
    end
  end

  def get_factors_odds(1, factors, _) do
    factors
  end

  def get_factors_odds(num, factors, curr_num) do
    cond do
      num / 2 < curr_num ->
        [num | factors]
      rem(num, curr_num) == 0 ->
        get_factors_odds(Kernel.trunc(num / curr_num), [curr_num | factors], curr_num)
      true ->
        get_factors_odds(num, factors, curr_num + 2)
    end
  end
end
