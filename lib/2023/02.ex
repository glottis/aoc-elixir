defmodule Aoc2302 do
  @bag %{"red" => 12, "green" => 13, "blue" => 14}
  def input(test \\ "") do
    File.read!("./input/2023/02" <> test <> ".txt")
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row, ": ") end)
    |> Enum.map(fn [h, t] -> {String.replace(h, "Game ", ""), t} end)
    |> Enum.map(fn {h, row} -> {h |> String.to_integer(), String.split(row, "; ")} end)
    |> Enum.map(fn {h, row} -> {h, Enum.map(row, fn rows -> String.split(rows, ", ") end)} end)
  end

  def part1(test \\ "") do
    input(test)
    |> Enum.map(fn {id, rows} ->
      {id, Enum.map(rows, fn row -> transform_score_row(row) |> validate_score(@bag) end)}
    end)
    |> Enum.map(fn {id, row} -> {id, Enum.min(row)} end)
    |> Enum.filter(fn {_id, key} -> key == true end)
    |> Enum.reduce(0, fn {id, _sb}, acc -> id + acc end)
  end

  # find fewest eg maximum of each color
  def part2(test \\ "") do
    input(test)
    |> Enum.map(fn {_id, rows} ->
      Enum.map(rows, fn row -> transform_score_row(row) end)
    end)
    |> Enum.map(&bubble_sort_score/1)
    |> Enum.map(&Map.values/1)
    |> Enum.map(fn row -> Enum.reduce(row, fn x, acc -> x * acc end) end)
    |> Enum.sum()
  end

  def bubble_sort_score([], sb), do: sb

  def bubble_sort_score([h | t], sb \\ %{}) do
    sb =
      Enum.reduce(h, sb, fn {key, val}, acc ->
        Map.update(acc, key, val, fn curr ->
          if val > curr do
            val
          else
            curr
          end
        end)
      end)

    bubble_sort_score(t, sb)
  end

  # %{"blue" => 3, "red" => 2}, %{"blue" => 1, "red" => 1} => false
  def validate_score(sb, bag) do
    Enum.reduce(sb, true, fn {key, val}, acc ->
      if acc and val <= bag[key] do
        true
      else
        false
      end
    end)
  end

  # in: "3 blue" => {"blue", 3}
  def transform_score(input) do
    [val, key] = String.split(input)
    {key, val |> String.to_integer()}
  end

  def transform_score_row(row), do: transform_score_row(row, %{})
  def transform_score_row([], scoreboard), do: scoreboard

  # in: ["3 blue", "4 red"] => {"blue" => 3, "red" => 4}
  def transform_score_row([h | t], scoreboard) do
    {key, val} = transform_score(h)
    scoreboard = Map.update(scoreboard, key, val, fn old_val -> val + old_val end)
    transform_score_row(t, scoreboard)
  end
end
