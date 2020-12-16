defmodule Aoc202005 do

  def input do
    File.read!("./input/202005.in")
    |> String.split("\n", trim: true)
  end

  def parse(x) do
    y = x |> String.graphemes()
    %{rows: Enum.take(y, 7),
      cols: Enum.take(y, -3)
    }
  end

  def part1 do
    input()
    |> Enum.map(&parse/1)
    |> Enum.map(&check_rows/1)
    |> Enum.map(&check_cols/1)
    |> Enum.map(&calc_res/1)
    |> Enum.max()
  end

  def part2 do
    input()
    |> Enum.map(&parse/1)
    |> Enum.map(&check_rows/1)
    |> Enum.map(&check_cols/1)
    |> Enum.map(&calc_res/1)
    |> Enum.sort()
    |> find_missing()
  end
  def find_missing([_x]), do: false

  def find_missing([x, y | rest]) do
    cond do
      x + 1 == y -> find_missing([y | rest])
      x + 1 != y ->
        IO.inspect(x + 1)
    end

  end

  def calc_res(x) do
    (x.row_id * 8) + x.col_id
  end

  def check_rows(x), do: check_rows(x, x.rows, 0..127)
  def check_rows(x, [], [y]), do: Map.put_new(x, :row_id, y)

  def check_rows(x, [h | t], rows) do
    half = Enum.count(rows) |> Integer.floor_div(2)
    case h do
      "F" ->
        check_rows(x, t, Enum.take(rows, half))
      "B" ->
        check_rows(x, t, Enum.take(rows, -half))
    end
  end

    def check_cols(x), do: check_cols(x, x.cols, 0..7)
    def check_cols(x, [], [y]), do: Map.put_new(x, :col_id, y)

    def check_cols(x, [h | t], cols) do
      half = Enum.count(cols) |> Integer.floor_div(2)
      case h do
        "L" ->
          check_cols(x, t, Enum.take(cols, half))
        "R" ->
          check_cols(x, t, Enum.take(cols, -half))
      end
    end
end
