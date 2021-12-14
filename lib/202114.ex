defmodule Aoc202114 do
  def input do
    File.read!("./input/202114.txt")
    |> String.split("\n", trim: true)
  end

  def part1 do
    [template | insertion_rules] = input

    fixed_rules =
      insertion_rules
      |> Enum.reduce(%{}, fn x, acc ->
        [k | v] = fix_rule(x)
        Map.put(acc, k, List.first(v))
      end)

    results =
      handle_insertion(template, fixed_rules, 10)
      |> String.graphemes()
      |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, fn y -> y + 1 end) end)

    {_k, max} = results |> Enum.max_by(fn {_k, v} -> v end)
    {_k, min} = results |> Enum.min_by(fn {_k, v} -> v end)

    IO.puts("Solution one is: #{max - min}")
  end

  def fix_rule(rule) do
    rule |> String.split(" -> ", trim: true)
  end

  def insert([b], _rules, results), do: results <> b

  def insert([a, b | t], rules, results \\ "") do
    v = rules[a <> b]
    val = a <> v
    insert([b | t], rules, results <> val)
  end

  def handle_insertion(_template, _rules, goal, results, steps) when goal == steps, do: results

  def handle_insertion(template, rules, goal, results \\ "", steps \\ 0) do
    split = template |> String.graphemes()

    results = insert(split, rules)

    handle_insertion(results, rules, goal, results, steps + 1)
  end
end
