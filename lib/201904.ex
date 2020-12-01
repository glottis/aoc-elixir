defmodule Aoc201904 do
  #defp input do
  #  File.read!("./input/201904.in")
  #end

  def input do
    171309..643603
    |> Enum.map(&Integer.digits/1)
  end


  def part1 do
    input()
    |> Enum.filter(&pw_check/1)
    |> length()
  end

  def part2 do
    input()
    |> Enum.filter(&pw_check/1)
    |> Enum.filter(&doubles_confirm/1)
    |> length()
  end


  def doubles_confirm([a, b, c, d, e, f]) do
    (a == b && b != c) ||
      (a != b && b == c && c != d) ||
      (b != c && c == d && d != e) ||
      (c != d && d == e && e != f) ||
      (d != e && e == f)
  end

  def pw_check(pw, ok \\ false)

  def pw_check([a, a | rest], _ok), do: pw_check([a | rest], true)
  def pw_check([a, b | _rest], _ok) when a > b, do: false
  def pw_check([_a, b | rest], ok), do: pw_check([b | rest], ok)
  def pw_check([_], ok), do: ok


end
