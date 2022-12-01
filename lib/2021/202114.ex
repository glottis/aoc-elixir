defmodule Aoc202114 do
  def input do
    File.read!("./input/202114.txt")
    |> String.split("\n", trim: true)
  end

  def solver do
    [template | insertion_rules] = input()
    pairs = template |> String.graphemes() |> fix_pairs()

    fixed_rules =
      insertion_rules
      |> Enum.reduce(%{}, fn x, acc ->
        [k, v] = fix_rule(x)
        Map.put(acc, k, v)
      end)

    IO.puts("Steps 10: #{count_pairs(pairs, fixed_rules, 10) |> count_freq}")

    IO.puts("Steps 40: #{count_pairs(pairs, fixed_rules, 40) |> count_freq}")
  end

  def count_freq(pairs) do
    new_pairs =
      pairs
      |> Enum.reduce(%{}, fn {k, v}, acc ->
        [a, _b] = k |> String.graphemes()
        Map.update(acc, a, v, fn y -> y + v end)
      end)

    min = new_pairs |> Enum.map(fn {_, v} -> v end) |> Enum.min()
    max = new_pairs |> Enum.map(fn {_, v} -> v end) |> Enum.max()

    max - min + 1
  end

  def count_pairs(pairs, _rules, target, steps) when target == steps,
    do: pairs

  def count_pairs(pairs, rules, target, steps \\ 0) do
    new_pairs =
      pairs
      |> Enum.reduce(%{}, fn pair, new_pairs ->
        {k, v} = pair
        [a, b] = k |> String.graphemes()
        to_insert = rules[k]
        updated_pairs = Map.update(new_pairs, a <> to_insert, v, fn y -> y + v end)
        Map.update(updated_pairs, to_insert <> b, v, fn y -> y + v end)
      end)

    count_pairs(new_pairs, rules, target, steps + 1)
  end

  def fix_pairs([_a], result), do: result

  def fix_pairs([a, b | r], result \\ %{}) do
    fix_pairs([b | r], Map.update(result, a <> b, 1, &(&1 + 1)))
  end

  def fix_rule(rule) do
    rule |> String.split(" -> ", trim: true)
  end
end
