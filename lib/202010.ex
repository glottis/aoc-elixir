defmodule Aoc202010 do

  def sorted_input do
    File.read!("./input/202010.in")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  def part1 do
    sorted_input()
    |> append_max()
    |> traverse(0, %{1 => 0, 2 => 0, 3 => 0})
    |> calc()
  end

  def calc(x), do: x[3] * x[1]

  def append_max(x) do
    [last | rest] = Enum.reverse(x)
    Enum.reverse([last + 3, last] ++ rest)
  end

  def traverse([x], prev, y) do
    res = x - prev
    old = y[res]
    %{y | res => old + 1}
  end

  def traverse([x | rest], prev, y) do
    res = x - prev
    old = y[res]
    traverse(rest, x, %{y | res => old + 1})
  end

  def part2 do
    sorted_input()
    |> append_max()
    |> traverse_p2(%{0=>1}, [1,2,3])
    |> IO.inspect()
  end

  def traverse_p2([x], y, l) do
    sum = helper(x, y, l)
    %{:res => sum, :last => x}
  end

  def traverse_p2([x | rest ], y, l) do
    sum = helper(x, y, l)
    traverse_p2(rest, Map.put(y, x, sum), l)
  end

  def helper(x, y, l) do
    Enum.map(l, fn e-> Map.get(y, x - e, 0) end) |> Enum.sum()
  end

end
