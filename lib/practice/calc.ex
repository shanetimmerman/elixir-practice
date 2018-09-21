defmodule Practice.Calc do
  def parse_float(text) do
  # convert a string to a float
    {num, _} = Float.parse(text)
    num
  end

  def is_float?(str) do
  # Checks if the string is able to be converted to a float
    case Float.parse(str) do
      {_, ""} ->
        true
      _ ->
        false
    end
  end

  def is_operator(str) do
  # Checks if the string is one of the supported operators
    case str do
      "+" -> true
      "-" -> true
      "*" -> true
      "/" -> true
      _ -> false
    end
  end

  def get_operation_level({_, str}) do
  # Gets the operation level (used for converting infix to postfix 
    case str do
      "+" -> 1
      "-" -> 1
      "*" -> 2
      "/" -> 2
    end
  end

  def parse_char(text) do
  # Converts character into a tuple of atom, value  
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
  # Converts all elements of the list into tuples
    Enum.map(lst, fn x -> parse_char(x) end)
  end


  def convert_to_postfix([head | tail], accumulator, operations) do
  # converts an infix expression (as a list) into a postfix list
    {typ, _} = head
    case typ do
      :num ->
        # If the next element is a number, add to the accumulator
        convert_to_postfix(tail, [head | accumulator], operations)
      :op ->
        case operations do
        # If its an operation, pop the operator stack until you reach one of 
        # lower level than tha current operation
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
  # Case where expression is still empty but operator stack isnt, recur
    convert_to_postfix([], [first | accumulator], rest)
  end

  def convert_to_postfix([], accumulator, []) do
  # Case where both expression and operation stack are empty, return accumulator
    accumulator
  end

  def convert_to_postfix(list) do
  # If one arg, call 3 argument function 
    convert_to_postfix(list, [], [])
  end

  def evaluate_postfix_expression(expression) do
  # If given one arg, call 2 argument function
    evaluate_postfix_expression(expression, [])
  end

  def evaluate_postfix_expression([head | tail], [first | [second | rest]]) do
  # Evalutes the postfix expression given a nonempty list and a stack of at least 2 elmeents.
    {typ, val} = head
    case typ do
      :num ->
        # If its a number, dd it to the stack
        evaluate_postfix_expression(tail, [val | [first | [second | rest]]])
      :op ->
        # If its an operator, apply it to the top two numbers in the stack, and replace 
        # them with the new value
        new_val = evaluate_stack_top(first, second, val)
        evaluate_postfix_expression(tail, [new_val | rest])
    end
  end

  def evaluate_postfix_expression([head | tail], stack) do
  # Evaluates the postfix expression given a nonempy list and a stack.
    {typ, val} = head
    case typ do
      :num ->
        # If its a number, add it to the stack
        evaluate_postfix_expression(tail, [val | stack])
      :op ->
        # If it is a operation, then there are not values to apply it to, so the
        # expression is malformed
        raise "Stack needs at lest 2 elements to evaluate"
    end
  end

  def evaluate_postfix_expression([], [first]) do
  # If given an empty expression and a one element stack, return the element (value of expression)
    first
  end

  def evaluate_postfix_expression(_, _) do
  # If given anything else, the equation must have been malformed.
    raise "Expression cannot be evaluated, empty"
  end

  def evaluate_stack_top(first, second, operator) do
  # Applies operation to two values.
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
