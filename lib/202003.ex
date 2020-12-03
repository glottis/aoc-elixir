defmodule Aoc202003 do

  def input do
    File.read!("./input/202003.in")
    |> String.split("\n", trim: true)
  end

  def part1 do
    input()
    |> Aoc202003.traverse()
    |> IO.inspect()
  end

  def part2 do
    Aoc202003.traverse(input(), {1, 1}) * Aoc202003.traverse(input(), {3, 1}) * Aoc202003.traverse(input(), {5, 1}) * Aoc202003.traverse(input(), {7, 1}) * Aoc202003.traverse(input(), {1, 2})
    |> IO.inspect()
  end

  defp list_pop([], _), do: []
  defp list_pop(x, 1), do: x # 1 default value, just return
  defp list_pop([_x | rest], steps), do: list_pop(rest, steps - 1)

  def traverse(x, conf \\ {3, 1}, pos \\ 0, sum \\ 0, dir \\ :right)
  def traverse([], _conf, _pos, sum, _dir), do: sum
  def traverse([x | rest], {r, d}, pos, sum, dir) do
   cond do
    pos + r > String.length(x) ->
      traverse([x <> x | rest], {r, d}, pos, sum, dir) # double current line
    dir == :right ->
      rest |> list_pop(d) |> traverse({r, d}, pos + r, sum, :down) # move right and set pos
    dir == :down and String.at(x, pos) == "#" ->
      traverse([x | rest], {r, d}, pos, sum + 1, :right)
    dir == :down ->
      traverse([x | rest], {r, d}, pos, sum, :right)
    end
  end
end
