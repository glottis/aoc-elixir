defmodule Aoc202007 do

  def input do
    File.read!("./input/202007.in")
    |> String.split("\n", trim: true)
    |> Enum.map(fn l -> String.split(l, ~r{\s*contain\s*}, trim: true)
    end)
  end

  def part1 do
    master = input() |> list_to_map()
    input()
    |> list_to_map()
    |> Enum.filter(fn b -> supp_check(b, master) end)
    |> Enum.count()
  end

  def part2 do
    input()
    |> list_to_map()
    |> deps_count("shiny gold bag")
  end

  def deps_count(m, b) do
    Enum.reduce(m[b], 0, fn %{bag: d, count: c}, acc ->
      #IO.inspect({b, d, acc, c})
      acc + c + c * deps_count(m, d) end)
  end


  def supp_check({_x, []}, _m), do: false
  def supp_check({_x, [h | _t]}, _m) when h.bag == "shiny gold bag", do: true
  def supp_check({x, [h | t]}, m) do
    y = m[h.bag]
    case supp_check({h.bag, y}, m) do
      false -> supp_check({x, t}, m)
      true -> true
    end
  end

  def list_to_map(x, m \\ %{})
  def list_to_map([], m), do: m
  def list_to_map([[main, tail] | rest], m) do
    y = Map.put(m, main |> String.replace(~r/bags\.*/, "bag"),
    tail |> String.split(~r{\s*,\s*}, trim: true)
    |> Enum.reject(&(&1 == "no other bags."))
    |> Enum.map(fn l ->
      [count, bag] = String.split(l, " ", parts: 2, trim: true)
      %{count: count |> String.to_integer, bag: bag |> String.replace(~r/bags*\.*/, "bag")}
    end))

    list_to_map(rest, y)
  end

end
