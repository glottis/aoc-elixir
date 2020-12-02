defmodule Aoc202002 do

  defstruct rule: "", pw: ""

  def input do
    File.read!("./input/202002.in")
    |> String.split("\n", trim: true)
    |> Enum.map(fn e ->
        String.split(e, ": ", trim: true)
    end)
  end

  def matches_rule?([r, s]) do
    [range, x] = String.split(r, " ", trim: true)
    [r0, r1] = String.split(range, "-", trim: true)
    sum = s |> String.graphemes |> Enum.count(&(&1 == x))
    sum >= String.to_integer(r0) && sum <= String.to_integer(r1)
  end

  def matches_rule_v2?([r, s]) do
    [range, x] = String.split(r, " ", trim: true)
    [r0, r1] = String.split(range, "-", trim: true)
    ss = s |> String.graphemes
    cond do
      x == Enum.fetch!(ss, String.to_integer(r0) - 1) && x == Enum.fetch!(ss, String.to_integer(r1) - 1) -> false
      x == Enum.fetch!(ss, String.to_integer(r0) - 1) || x == Enum.fetch!(ss, String.to_integer(r1) - 1) -> true
      true -> false
    end

  end

  def part1 do
    input() |> Enum.filter(&Aoc202002.matches_rule?/1) |> Enum.count()
  end

  def part2 do
    input() |> Enum.filter(&Aoc202002.matches_rule_v2?/1) |> Enum.count()
  end
end
