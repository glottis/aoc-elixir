defmodule Aoc202006 do

  def input do
    File.read!("./input/202006.in")
    |> String.split("\n\n")
    |> Enum.map(fn l -> String.split(l, "\n") end)
  end

  def part1 do
    input()
    |> Enum.map(&conc_split/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def part2 do
    input()
    |> Enum.map(&count_everyone/1)
    |> Enum.sum()
  end

  def count_everyone([x]), do: String.length(x) # one element == one person, no need for group freq
  def count_everyone(x) when is_list(x) do
    x
    |> conc_split()
    |> Enum.frequencies
    |> Enum.count(fn {_key, value} -> value > 1 end)
  end

  def conc_split([x]), do: String.graphemes(x)
  def conc_split([x, y]), do: conc_split([x <> y])
  def conc_split([x, y | rest]), do: conc_split([x <> y | rest])
end
