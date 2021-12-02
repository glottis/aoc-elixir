defmodule Aoc202102 do
  def input do
    File.read!("./input/202102.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn e ->
      String.split(e, " ", trim: true)
    end)
    |> Enum.map(fn [dir, val] -> {String.downcase(dir), String.to_integer(val)} end)
  end

  def part1 do
    input()
    |> p1_solver
    |> calc()
  end

  def part2 do
    input() |> p2_solver |> calc
  end

  def p1_solver(enum) do
    enum
    |> Enum.reduce({0, 0}, fn {dir, val}, acc ->
      {x, y} = acc

      case dir do
        "forward" -> {x + val, y}
        "down" -> {x, y + val}
        "up" -> {x, y - val}
      end
    end)
  end

  def p2_solver(enum) do
    enum
    |> Enum.reduce(%{x: 0, y: 0, aim: 0}, fn {dir, val}, acc ->
      case dir do
        "forward" -> %{x: acc.x + val, y: acc.y + acc.aim * val, aim: acc.aim}
        "down" -> %{x: acc.x, y: acc.y, aim: acc.aim + val}
        "up" -> %{x: acc.x, y: acc.y, aim: acc.aim - val}
      end
    end)
  end

  defp calc({x, y}), do: x * y
  defp calc(%{x: x, y: y, aim: _x}), do: x * y
end
