defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def is_float?(str) do
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

  def get_operation_level({_, str}) do
    case str do
      "+" -> 1
      "-" -> 1
      "*" -> 2
      "/" -> 2
    end
  end

  def parse_char(text) do
    cond do
      is_float?(text) ->
        {:num, parse_float(text)}
      is_operator(text) ->
        {:op, text}
      true ->
        raise "Not a valid string"
    end
  end

  def tag_tokens(lst) do
    Enum.map(lst, fn x -> parse_char(x) end)
  end


  def convert_to_postfix([head | tail], accumulator, operations) do
    {typ, _} = head
    case typ do
      :num ->
        convert_to_postfix(tail, [head | accumulator], operations)
      :op ->
        case operations do
          [first | rest] ->
            operation_level = get_operation_level(head)
            if get_operation_level(first) < operation_level do
              convert_to_postfix(tail, accumulator, [head | operations])
            else
              convert_to_postfix([head | tail], [first | accumulator], rest)
            end
          [] ->
            convert_to_postfix(tail, accumulator, [head])
        end
      _ ->
        raise "Invalid atom detected"
    end
  end

  def convert_to_postfix([], accumulator, [first | rest]) do
    convert_to_postfix([], [first | accumulator], rest)
  end

  def convert_to_postfix([], accumulator, []) do
    accumulator
  end

  def convert_to_postfix(list) do
    convert_to_postfix(list, [], [])
  end

  def evaluate_postfix_expression(expression) do
    evaluate_postfix_expression(expression, [])
  end

  def evaluate_postfix_expression([head | tail], [first | [second | rest]]) do
    {typ, val} = head
    case typ do
      :num ->
        evaluate_postfix_expression(tail, [val | [first | [second | rest]]])
      :op ->
        new_val = evaluate_stack_top(first, second, val)
        evaluate_postfix_expression(tail, [new_val | rest])
    end
  end

  def evaluate_postfix_expression([head | tail], stack) do
    {typ, val} = head
    case typ do
      :num ->
        evaluate_postfix_expression(tail, [val | stack])
      :op ->
        raise "Stack needs at lest 2 elements to evaluate"
    end
  end

  def evaluate_postfix_expression([], [first]) do
    first
  end

  def evaluate_postfix_expression(_, _) do
    raise "Expression cannot be evaluated, empty"
  end

  def evaluate_stack_top(first, second, operator) do
    case operator do
      "+" ->
        second + first
      "-" ->
        second - first
      "*" ->
        second * first
      "/" ->
        second / first
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> convert_to_postfix
    |> Enum.reverse
    |> evaluate_postfix_expression
  end
end
