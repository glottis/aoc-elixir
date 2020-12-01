defmodule Aoc201902 do

  defp input do
    File.read!("./input/201902.in")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
  def part1 do
    input() |> patch(12,2) |> AocIntcode.processPrg()

  end

  def part2 do
    input() |> sloppy_bruteforce()
  end

  defp sloppy_bruteforce(pgr) do
    for n <- 0..99 do
      for nn <- 0..99 do

          with [19690720 | _] <- pgr |> patch(n, nn) |> AocIntcode.processPrg() do
            sum = (100 * n) + nn
            exit({:found!,sum})
          end

      end

    end

  end

  defp patch(pgr, first, second) do
    List.replace_at(pgr, 1, first) |> List.replace_at(2, second)

  end

end
