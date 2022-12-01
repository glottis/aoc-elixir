defmodule Aoc202201 do
  def input do
    File.read!("./input/2022/202201.txt")
    |> String.split("\n")
    |> Enum.map(fn x ->
      if x != "" do
        x |> String.to_integer()
      else
        x
      end
    end)
  end

  def part1([], current, max) when current > max, do: current
  def part1([], current, max) when max >= current, do: max

  def part1(["" | t], current, max) do
    case current > max do
      true -> part1(t, 0, current)
      _ -> part1(t, 0, max)
    end
  end

  def part1([h | t], current, max), do: part1(t, current + h, max)

  def part2([], current, sums),
    do: ([current] ++ sums) |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum()

  def part2(["" | t], current, sums), do: part2(t, 0, [current] ++ sums)

  def part2([h | t], current, sums), do: part2(t, current + h, sums)
end
