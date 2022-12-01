defmodule Aoc202110 do
  def input do
    File.read!("./input/202110.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.graphemes(x) end)
  end

  def count_chunks(chunk, entries \\ %{}) do
    chunk |> Enum.reduce(entries, fn x, acc -> Map.update(acc, x, 1, fn y -> y + 1 end) end)
  end
end
