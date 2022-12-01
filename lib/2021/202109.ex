defmodule Aoc202109 do
  def input do
    File.read!("./input/202109.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn x ->
      x
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
    end)
    |> Enum.with_index()
  end

  def part1 do
    input()
    |> create_height_map()
    |> find_smaller_adjacents_loc
    |> Enum.map(&(&1 + 1))
    |> Enum.sum()
  end

  def part2 do
    height_map =
      input()
      |> create_height_map()

    found_basins_loc =
      height_map
      |> find_smaller_adjacents_loc(true)
      |> Enum.reduce(%{}, fn {x, y, z}, acc -> Map.put(acc, {x, y}, z) end)

    found_basins_loc
    |> find_downard_wrapper(height_map)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def find_downard_wrapper(loc, height_map) do
    loc |> Enum.map(fn node -> [node] |> find_downward_flows(height_map) |> Enum.count() end)
  end

  def find_downward_flows([], _height_map, results), do: results

  def find_downward_flows([{{x, y}, k} = current_node | t], height_map, results \\ %{}) do
    case results[current_node] do
      nil ->
        entries =
          [
            {{x, y - 1}, height_map[{x, y - 1}]},
            {{x + 1, y}, height_map[{x + 1, y}]},
            {{x, y + 1}, height_map[{x, y + 1}]},
            {{x - 1, y}, height_map[{x - 1, y}]}
          ]
          |> Enum.filter(fn {{_q, _w}, e} -> !is_nil(e) && e > k && e != 9 end)
          |> Enum.filter(fn {{q, w}, _e} -> is_nil(results[{q, w}]) end)

        added_entries =
          ([current_node] ++ entries)
          |> Enum.reduce(results, fn {{q, w}, e}, acc -> Map.put(acc, {q, w}, e) end)

        find_downward_flows(entries ++ t, height_map, added_entries)

      _ ->
        find_downward_flows(t, height_map, results)
    end
  end

  def find_basins(basins, h_m) do
  end

  def find_smaller_adjacents_loc(h_m, cordinates_only \\ false) do
    h_m
    |> Enum.reduce([], fn {{x, y}, k}, acc ->
      neigh =
        [h_m[{x, y - 1}], h_m[{x + 1, y}], h_m[{x, y + 1}], h_m[{x - 1, y}]]
        |> Enum.filter(fn x -> !is_nil(x) end)
        |> Enum.all?(&(&1 > k))

      case cordinates_only do
        true ->
          case neigh do
            true -> [{x, y, h_m[{x, y}]}] ++ acc
            _ -> acc
          end

        false ->
          case neigh do
            true -> [k] ++ acc
            _ -> acc
          end
      end
    end)
  end

  def create_height_map([], height_map), do: height_map
  def create_height_map([{[], _y} | t], height_map), do: create_height_map(t, height_map)

  def create_height_map([{h, y} | t], height_map \\ %{}) do
    [{k, x} | tt] = h
    create_height_map([{tt, y} | t], Map.put_new(height_map, {x, y}, k))
  end
end
