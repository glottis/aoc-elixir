defmodule Aoc2304 do
  import Bitwise

  def input(test \\ "") do
    File.read!("./input/2023/04" <> test <> ".txt")
    |> String.split("\n")
    |> Enum.map(fn row -> Regex.replace(~r/Card \d:\s/, row, "") end)
    |> Enum.map(fn row -> String.split(row, " | ") end)
    |> Enum.map(fn rows -> rows |> Enum.map(&String.split/1) end)
  end

  def toIntegers(input) do
    input |> Enum.map(&String.to_integer/1)
  end

  def intoMap(input) do
    input |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, "") end)
  end

  def computeScore(input, score) do
    input
    |> Enum.reduce(0, fn x, acc ->
      if Map.has_key?(score, x) do
        if acc > 0 do
          acc <<< 1
        else
          1
        end
      else
        acc
      end
    end)
  end

  def computeScoreV2(input, score) do
    input
    |> Enum.reduce(0, fn x, acc ->
      if Map.has_key?(score, x) do
        acc + 1
      else
        acc
      end
    end)
  end

  def part1(test \\ "") do
    input(test)
    |> Enum.map(fn [a, b] -> {a |> intoMap, b} end)
    |> Enum.map(fn {score, b} -> {score, computeScore(b, score)} end)
    |> Enum.map(fn {_score, points} -> points end)
  end

  def part2(test) do
    data = input(test)

    data
    |> Enum.map(fn [a, b] -> {a |> intoMap, b} end)
    |> generateInstances(length(data))
    |> countCards()
    |> Map.values()
    |> Enum.sum()
  end

  def generateInstances(data, len) do
    instances = 1..len |> Enum.to_list() |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, 1) end)
    {data, instances}
  end

  def countCards({[], copies}, _index), do: copies

  def countCards({[{score, b} | t], copies}, index \\ 1) do
    matchNum = computeScoreV2(b, score)

    copies = applyRounds(matchNum, index + 1, copies[index], copies)
    countCards({t, copies}, index + 1)
  end

  def applyRounds(_match, _index, 0, copies), do: copies

  def applyRounds(matchNum, index, rounds, copies) do
    copies = generateCopies(index, matchNum, copies)
    applyRounds(matchNum, index, rounds - 1, copies)
  end

  def generateCopies(_start, 0, copies), do: copies

  def generateCopies(start, max, copies) do
    copies = Map.update(copies, start, 1, fn x -> x + 1 end)
    generateCopies(start + 1, max - 1, copies)
  end
end
