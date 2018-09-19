defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def is_float(str) do
    case Float.parse(str) do
      {_, ""} ->
        true
      _ ->
        false
    end
  end

  def is_operator(str) do
    case str do
      "+" -> true
      "-" -> true
      "*" -> true
      "/" -> true
      _ -> false
    end
  end

  def parse_char(text) do
    case text do
      is_float(text) ->
        {:num, parse_float(text)}
      is_operator(text) ->
        {:op, text}
      _ ->
        raise "Not a valid string"
    end
  end

  def tag_tokens(lst) do
    Enum.map(lst, parse_char)
  end

  def convert_to_postfix([head | tail], accumulator, operations) do
    for element in lst:
      case atom:
        :num ->
          convert_to_postfix(tail, [head | accumulator], operations)
        :op ->
          case operations do
            #TODO figure out how ot pop off operations when converting to postfix
            [first | rest] ->
          end
        _ ->
          raise "Invalid atom detecetd"
  end

  def convert_to_postfix([], accumulator, operations) do

  end

  def convert_to_postfix(list) do
    convert_to_postfix(list, [], [])

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> convert_to_postfix

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
