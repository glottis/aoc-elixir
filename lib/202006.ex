defmodule Aoc202006 do

  def input do
    File.read!("./input/202006.in")
    |> String.split("\n\n")
    |> Enum.map(fn l -> String.split(l, "\n") end)
    |> Enum.map(&dedup_list/1)
  end


  def dedup_list(x, new \\ [])
  def dedup_list([], y), do: y
  def dedup_list([x | rest], new) do
    y = String.graphemes(x) |> Enum.uniq() |> Enum.join()
    dedup_list(rest, [y] ++ new)
  end

  def part1 do
    input()
    |> Enum.map(&join_split/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def part2 do
    input()
    |> Enum.map(&count_everyone/1)
    |> Enum.sum()
  end

  def count_everyone([x]), do: String.length(x) # one element == one person, no need for group count
  def count_everyone(x) do
    x
    |> join_split()
    |> Enum.frequencies
    |> Enum.count(fn {_key, value} -> value == length(x) end) # compare against the number ppl in the group
  end

  @doc """
  Joins all elements and then splits them: eg
  [aa, ab, ac] => aaabac => [a, a, a, b, a, c]
  """
  def join_split(x) do
    x
    |> Enum.join()
    |> String.graphemes()
  end
end
