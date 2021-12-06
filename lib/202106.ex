defmodule Aoc202106 do
  def input do
    File.read!("./input/202106.txt")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1 do
    input() |> count_fish(80, [], [])
  end

  def count_fish([], target, new_list, new_borns, day),
    do: count_fish(new_list ++ new_borns, target, [], [], day + 1)

  def count_fish(x, target, _new_list, _new_borns, days) when target == days, do: length(x)

  def count_fish([h | t], target, new_list, new_borns, day \\ 0) do
    new_state = h - 1

    case new_state do
      -1 -> count_fish(t, target, new_list ++ [6], new_borns ++ [8], day)
      _ -> count_fish(t, target, new_list ++ [new_state], new_borns, day)
    end
  end
end
