defmodule Aoc2303 do
  @part1_regex ~r/[^\.\d]/
  @part2_regex ~r/\d/

  def input(test \\ "") do
    File.read!("./input/2023/03" <> test <> ".txt")
    |> String.split("\n")
  end

  def input_XY(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {data, y} -> {data |> String.graphemes() |> Enum.with_index(), y} end)
  end

  def input_regex(input) do
    input
    |> Enum.map(fn row -> Regex.scan(~r/\d*/, row) |> Enum.with_index() end)
    |> Enum.with_index()
  end

  def lookup({x, y}, m, regex) do
    n = Regex.match?(regex, m[{x, y + 1}] || "")
    ne = Regex.match?(regex, m[{x + 1, y + 1}] || "")
    e = Regex.match?(regex, m[{x + 1, y}] || "")
    se = Regex.match?(regex, m[{x + 1, y - 1}] || "")
    s = Regex.match?(regex, m[{x, y - 1}] || "")
    sw = Regex.match?(regex, m[{x - 1, y - 1}] || "")
    w = Regex.match?(regex, m[{x - 1, y}] || "")
    nw = Regex.match?(regex, m[{x - 1, y + 1}] || "")
    [n, ne, e, se, s, sw, w, nw] |> Enum.member?(true)
  end

  def lookup_wrapper({word, x}, y, m) do
    words = String.graphemes(word) |> Enum.with_index()

    Enum.reduce(words, [], fn {_s, ox}, acc ->
      [lookup({ox + x, y}, m, @part1_regex)] ++ acc
    end)
    |> Enum.reverse()
    |> Enum.member?(true)
  end

  def part1(test \\ "") do
    m = input(test) |> input_XY |> create_map()

    input(test)
    |> input_regex()
    |> Enum.map(fn {data, y} ->
      {data |> corr_x |> Enum.filter(fn {z, _x} -> String.length(z) != 0 end), y}
    end)
    |> Enum.filter(fn {list, _y} -> !Enum.empty?(list) end)
    |> Enum.map(fn {rows, y} -> Enum.map(rows, fn row -> {row, lookup_wrapper(row, y, m)} end) end)
    |> List.flatten()
    |> Enum.filter(fn {_, match} -> match == true end)
    |> Enum.map(fn {{val, _}, _} -> String.to_integer(val) end)
    |> Enum.sum()
  end

  def corr_x([], new, _), do: new |> Enum.reverse()

  def corr_x([{[input], x} | t], new \\ [], prev \\ 0) do
    sl = String.length(input)

    add =
      if sl > 0 do
        sl - 1
      else
        sl
      end

    corr_x(t, [{input, x + prev}] ++ new, add + prev)
  end

  # find fewest eg maximum of each color
  def part2(test \\ "") do
    input(test)
  end

  def create_map([], m), do: m

  def create_map([{rows, y} | t], m \\ %{}) do
    m =
      Enum.reduce(rows, m, fn {c, x}, acc ->
        Map.put(acc, {x, y}, c)
      end)

    create_map(t, m)
  end
end
