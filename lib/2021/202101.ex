defmodule Aoc202101 do
  def input do
    File.read!("./input/202101.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1 do
    input() |> count_cases()
  end

  def part2 do
    input() |> generate_window_sums([]) |> count_cases()
  end

  def count_cases([], sum, _prev), do: sum
  def count_cases([h | t]), do: count_cases(t, 0, h)

  def count_cases([h | t], sum, prev) do
    cond do
      h > prev -> count_cases(t, sum + 1, h)
      true -> count_cases(t, sum, h)
    end
  end

  def generate_window_sums([_a, _b | []], sums), do: sums

  def generate_window_sums([a, b, c | t], sums),
    do: generate_window_sums([b, c | t], sums ++ [a + b + c])
end
