defmodule Aoc201903 do
  defp wires do
    File.read!("./input/201903.in")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(fn
        "U" <> line -> {:Up, String.to_integer(line)}
        "R" <> line -> {:Right, String.to_integer(line)}
        "D" <> line -> {:Down, String.to_integer(line)}
        "L" <> line -> {:Left, String.to_integer(line)}
      end)
    end)
  end

  def part1 do
    [input0 , input1] =
      wires()
      |> Enum.map(&connect/1)
      |> Enum.map(&MapSet.new/1)

    MapSet.intersection(input0, input1)
    |> MapSet.delete({0,0})
    |> Enum.map(fn x ->
      abs(elem(x,0)) + abs(elem(x, 1))
    end)
    |> Enum.min()

  end

  def part2 do
    [input0 , input1] =
      wires()
      |> Enum.map(&connect/1)

      wired0 = input0 |> MapSet.new()
      wired1 = input1 |> MapSet.new()

    MapSet.intersection(wired0, wired1)
    |> MapSet.delete({0,0})
    |> Enum.map(fn wire ->
      Enum.find_index(input0, fn pos -> pos == wire end) +
      Enum.find_index(input1, fn pos -> pos == wire end)
    end)
    |> Enum.min()

  end

  defp connect(wire, acc \\ [{0, 0}])
  defp connect([], acc), do: Enum.reverse(acc)
  defp connect([{_, 0} | rest ], acc), do: connect(rest, acc)

  defp connect([{dir, val} | rest], acc) do

    [{x, y} | _ ] = acc

    pos =
      case dir do
        # {x, y}
        :Up -> {x, y + 1 }
        :Down -> {x, y - 1 }
        :Right -> {x + 1, y}
        :Left -> {x - 1, y}
      end

      connect([{dir, val - 1} | rest], [pos | acc])

  end


end
