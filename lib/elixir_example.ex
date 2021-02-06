defmodule ElixirExample do
  @error {:error, "Invalid arguments."}
  def main(args) do
    {status, result} = parse_args(args)

    case status do
      :ok -> result |> get_fizz_buzz() |> Enum.each(&IO.puts(&1))
      :error -> IO.puts(result)
    end
  end

  defp parse_args([]), do: @error

  defp parse_args(args) do
    [head | tail] = args
    regex = ~R/[1-9][0-9]*/

    case {head =~ regex, tail} do
      {true, []} -> {:ok, String.to_integer(head)}
      {_, _} -> @error
    end
  end

  defp get_fizz_buzz(count), do: 1..count |> Enum.map(&to_fizz_buzz/1)

  defp to_fizz_buzz(num), do: to_fizz_buzz(rem(num, 3), rem(num, 5), num)
  defp to_fizz_buzz(0, 0, _), do: "FizzBuzz"
  defp to_fizz_buzz(0, _, _), do: "Fizz"
  defp to_fizz_buzz(_, 0, _), do: "Buzz"
  defp to_fizz_buzz(_, _, n), do: n
end
