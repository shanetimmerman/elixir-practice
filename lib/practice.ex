defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    Practice.Factor.factor(x)
  end

  def palindrome(str) do
    # Is it a palindrome? If same backwards as forwards, then return true. Else false.
    s = String.trim(str)
    String.reverse(s) == s
  end
end
