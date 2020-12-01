defmodule Aoc201901 do

  defp input do
    File.read!("./input/201901.in")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
  def part1 do
    input() |> Enum.map(&Aoc201901.calcFuel/1) |> Enum.sum()
  end

  def part2 do
    input() |> Enum.map(&Aoc201901.calcFuelv2/1) |> Enum.sum()
  end

  def calcFuel(mass) do
    max(div(mass, 3) - 2, 0)
  end

  def calcFuelv2(mass, x \\ 0) do
    f = calcFuel(mass)
    cond do
      f == 0 -> x
      f > 0 -> calcFuelv2(f, x + f)
    end
  end

end
