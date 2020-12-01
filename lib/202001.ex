defmodule Aoc202001 do

  def input do
    File.read!("./input/202001.in")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1 do
      [{x, y} | _] = for x <- input(), y <- input(), x + y == 2020, do: {x, y}
      IO.inspect(x * y)
  end

  def part2 do
    [{x, y, z} | _] = for x <- input(), y <- input(), z <- input(), x + y + z == 2020, do: {x, y, z}
    IO.inspect(x * y * z)
  end

end
