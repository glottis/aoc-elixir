defmodule Aoc202104 do
  def input do
    data =
      File.read!("./input/202104.txt")
      |> String.split("\n", trim: true)

    drawn_numbers = data |> get_drawn_numbers

    boards = data |> Enum.drop(1) |> Enum.chunk_every(5) |> Enum.with_index() |> create_boards

    {drawn_numbers, boards}
  end

  def part1 do
    {drawn_numbers, boards} = input()
  end

  def get_drawn_numbers(input) do
    input |> List.first() |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def mark_board(board, number) do
  end

  def check_board() do
  end

  def create_boards([], boards), do: boards

  def create_boards([{b, k} | t], boards \\ []) do
    fixed =
      b
      |> Enum.map(fn x ->
        x
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.map(fn x -> {x, 0} end)
      end)

    create_boards(t, [{fixed, k}] ++ boards)
  end
end
