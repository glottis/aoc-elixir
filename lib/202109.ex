defmodule Aoc202109 do
  def input do
    File.read!("./input/202109.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn x ->
      x
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def part1 do
    {heat_map, maxs} = input() |> create_heat_map()

    check_heat_map(heat_map, maxs) |> Enum.map(&(&1 + 1)) |> Enum.sum()
  end

  defp find_smaller_adjacents_loc(hm, x, y) do
    curr_pos = hm[{x, y}]
    neighs = [hm[{x, y - 1}], hm[{x + 1, y}], hm[{x, y + 1}], hm[{x - 1, y}]]

    smaller =
      neighs
      |> Enum.filter(fn x -> !is_nil(x) end)
      |> Enum.filter(fn x -> x < curr_pos end)

    {curr_pos, smaller}
  end

  def check_heat_map(_hm, {_max_x, max_y}, low_points, _x, y) when y > max_y, do: low_points

  def check_heat_map(hm, {max_x, max_y}, low_points, x, y) when max_x == x,
    do: check_heat_map(hm, {max_x, max_y}, low_points, 0, y + 1)

  def check_heat_map(hm, maxs, low_points \\ [], x \\ 0, y \\ 0) do
    {curr_pos, smaller} = find_smaller_adjacents_loc(hm, x, y)

    case length(smaller) do
      0 ->
        check_heat_map(
          hm,
          maxs,
          [curr_pos] ++ low_points,
          x + 1,
          y
        )

      _ ->
        check_heat_map(hm, maxs, low_points, x + 1, y)
    end
  end

  def create_heat_map([[] | []], heat_map, x, y),
    do: {heat_map, {x, y}}

  def create_heat_map([[] | t], heat_map, _x, y), do: create_heat_map(t, heat_map, 0, y + 1)

  def create_heat_map([[h | tt] | t], heat_map \\ %{}, x \\ 0, y \\ 0) do
    create_heat_map([tt | t], Map.put_new(heat_map, {x, y}, h), x + 1, y)
  end
end
