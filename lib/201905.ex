defmodule Aoc201905 do
  defp input do
    File.read!("./input/201905.in")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  #WIP
  def part1 do
    input() |> Enum.slice(0..6)
  end

end
