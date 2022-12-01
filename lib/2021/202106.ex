defmodule Aoc202106 do
  def input do
    File.read!("./input/202106.txt")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{}, fn el, acc ->
      Map.update(acc, el, 1, fn v -> v + 1 end)
    end)
  end

  def part1 do
    input() |> count_fish(80)

    input() |> count_fish(256)
  end

  def count_fish(map, target, %{}, days, _rounds) when target == days,
    do: IO.puts("Day #{days}: #{map |> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)}")

  defp count_old_state(map, rounds) do
    case result = map[rounds] do
      nil -> 0
      _ -> result
    end
  end

  def count_fish(map, target, new_map, days, 0 = rounds) do
    count_old_map = count_old_state(map, rounds)

    count_fish(
      Map.update(new_map, 6, count_old_map, fn current_val -> count_old_map + current_val end)
      |> Map.put_new(8, count_old_map),
      target,
      %{},
      days + 1,
      8
    )
  end

  def count_fish(map, target, new_map \\ %{}, days \\ 0, rounds \\ 8) do
    count_old_state = count_old_state(map, rounds)

    count_fish(
      map,
      target,
      Map.put_new(new_map, rounds - 1, count_old_state),
      days,
      rounds - 1
    )
  end
end
