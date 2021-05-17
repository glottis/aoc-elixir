defmodule Aoc202011 do
  @part1_rule 4
  @part2_rule 5

  # . => floor, L => empty seat, # => occupied
  def input do
    File.read!("./input/202011.in")
    |> String.split("\n", trim: true)
    |> Enum.with_index(0)
    |> Enum.map(fn {x, index} -> {x |> String.codepoints |> Enum.with_index(0), index} end)
  end

  def part1 do
    input()
    |> map_wrapper(%{})
    |> traverse_p1(nil)
    |> count_occupied
  end

  def part2 do
    input()
    |> map_wrapper(%{})
    |> traverse_p2(nil)
    |> count_occupied
  end

  def traverse_p1(m, rounds) do
    case rounds do
      x when x > 0 or x == nil -> # init round or not, time to reset
        keys = Map.keys(m)
        {m, rounds} = update_new_seat(m, keys, 0, @part1_rule)
        m = update_current_seat(m, keys)
        traverse_p1(m, rounds)
      0 -> m
    end
  end


  def traverse_p2(m, rounds) do
    case rounds do
      x when x > 0 or x == nil -> # init round or not, time to reset
        keys = Map.keys(m)
        {m, rounds} = update_new_seat_part2(m,keys, 0, @part2_rule)
        m = update_current_seat(m, keys)
        traverse_p2(m, rounds)
      0 -> m
    end
  end

  def find_adjacent(_m, {_x,_y}, [], res), do: res |> Enum.count(&(&1.current == "#" ))
  def find_adjacent(m, {x,y}, [dir | t], res) do
    case dir do
      "N" ->
        hit = Map.get(m,{x,y+1}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "NE" ->
        hit = Map.get(m,{x+1,y+1}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "E" ->
        hit = Map.get(m,{x+1,y}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "SE" ->
        hit = Map.get(m,{x+1,y-1}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "S" ->
        hit = Map.get(m,{x,y-1}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "SW" ->
        hit = Map.get(m,{x-1,y-1}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "W" ->
        hit = Map.get(m,{x-1,y}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
      "NW" ->
        hit = Map.get(m,{x-1,y+1}, %{:current => ""})
        find_adjacent(m, {x,y}, t, [hit] ++ res)
    end
  end
  def find_adjacent_part2(_m, _, [], res, _curr), do: res |> Enum.count(&(&1.current == "#" ))
  def find_adjacent_part2(m, {x,y}, [dir | t], res, curr) do
    case dir do
      "N" ->
        hit = Map.get(m,{x,y + curr}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "NE" ->
        hit = Map.get(m,{x+curr, y+curr}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "E" ->
        hit = Map.get(m,{x+curr,y}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "SE" ->
        hit = Map.get(m,{x+curr,y-curr}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "S" ->
        hit = Map.get(m,{x,y-curr}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "SW" ->
        hit = Map.get(m,{x-curr,y-curr}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "W" ->
        hit = Map.get(m,{x-curr,y}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
      "NW" ->
        hit = Map.get(m,{x-curr,y+curr}, %{:current => ""})
        case hit.current do
          "" ->  find_adjacent_part2(m, {x,y}, t, res, 1)
          z when z == "L" or z == "#" -> find_adjacent_part2(m, {x,y}, t, [hit] ++ res, 1)
           _ ->  find_adjacent_part2(m, {x,y}, [dir | t], [hit] ++ res, curr + 1)
        end
    end
  end
  def update_current_seat(m, []), do: m
  def update_current_seat(m, [h | t]) do
    new = m[h].new
    case m[h].current do
      "." -> update_current_seat(m, t)
      _ -> update_current_seat(%{m | h => %{:current => new, :new => ""}}, t)
    end
  end
  def update_new_seat_part2(m, [], count, _rule), do: {m, count}
  def update_new_seat_part2(m, [{x,y} | t], count, rule) do
    hits = find_adjacent_part2(m, {x,y}, ["N", "NE", "E", "SE", "S", "SW", "W", "NW"], [], 1)
    case {hits, m[{x,y}].current} do
      {_, "."} -> update_new_seat_part2(m, t, count, rule) # do nothing when floor
      {hits, "#"} when hits >= rule ->
        update_new_seat_part2(put_in(m, [{x,y}, :new], "L"), t, count + 1, rule) # empty the seat
      {0, "L"} -> update_new_seat_part2(put_in(m, [{x,y}, :new], "#"), t, count + 1, rule) # fill the seat
      {_, current} -> update_new_seat_part2(put_in(m, [{x,y}, :new], current), t, count, rule) # current -> new, eg no change
    end
  end

  def update_new_seat(m, [], count, _rule), do: {m, count}
  def update_new_seat(m, [{x,y} | t], count, rule) do
    hits = find_adjacent(m, {x,y}, ["N", "NE", "E", "SE", "S", "SW", "W", "NW"], [])
    case {hits, m[{x,y}].current} do
      {_, "."} -> update_new_seat(m, t, count, rule) # do nothing when floor
      {hits, "#"} when hits >= rule ->
        update_new_seat(put_in(m, [{x,y}, :new], "L"), t, count + 1, rule) # empty the seat
      {0, "L"} -> update_new_seat(put_in(m, [{x,y}, :new], "#"), t, count + 1, rule) # fill the seat
      {_, current} -> update_new_seat(put_in(m, [{x,y}, :new], current), t, count, rule) # current -> new, eg no change
    end
  end

  def map_wrapper([{h, y_pos} | t], m) do
    case t do
      [] ->
        map_builder(h, y_pos, m)
       _ ->
        map_wrapper(t, map_builder(h, y_pos, m))
    end
  end

  def map_helper(m, l) do
    x_total_len = Map.keys(m) |> length()
    y_len = length(l)
    %{y: y_len, x: Kernel.div(x_total_len, y_len)}
  end
  def map_builder([{v, x_pos} | rest], y_pos, m) do
    case rest do
      [] ->
        Map.put(m, {x_pos, y_pos}, %{:current => v, :new => ""})
      _ ->
        m = Map.put(m, {x_pos, y_pos}, %{:current => v, :new => ""})
        map_builder(rest, y_pos, m)
    end
  end

  def count_occupied(m) do
    m |> Map.keys() |> Enum.map(&(m[&1].current)) |> Enum.count(&(&1 == "#"))
  end

end
