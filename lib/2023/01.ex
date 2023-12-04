defmodule Aoc2301 do
  @part2_sigil ~r/\d|one|two|three|four|five|six|seven|eight|nine/
  @part2_sigil_rev ~r/\d|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno/
  @part2_map %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9",
    "1" => "1",
    "2" => "2",
    "3" => "3",
    "4" => "4",
    "5" => "5",
    "6" => "6",
    "7" => "7",
    "8" => "8",
    "9" => "9",
    "enin" => "9",
    "thgie" => "8",
    "neves" => "7",
    "xis" => "6",
    "evif" => "5",
    "ruof" => "4",
    "eerht" => "3",
    "owt" => "2",
    "eno" => "1"
  }

  def input(test \\ "") do
    File.read!("./input/2023/01" <> test <> ".txt")
    |> String.split("\n")
  end

  def part1(test \\ "") do
    input(test)
    |> findFirstLast()
    |> Enum.sum()
  end

  def part2(test \\ "") do
    input(test)
    |> findFirstLast("part2")
    |> Enum.sum()
  end

  def findFirstLast(input, part \\ "part1") do
    input
    |> Enum.reduce([], fn x, acc ->
      first = getDigit(x, part)
      last = x |> String.reverse() |> getDigit(part <> "_rev")
      fixed = (first <> last) |> String.to_integer()
      [fixed] ++ acc
    end)
  end

  def getDigit(s, part) do
    case part do
      "part1" ->
        getDigit(s)

      "part1_rev" ->
        getDigit(s)

      "part2" ->
        [num | _] = Regex.run(@part2_sigil, s)
        @part2_map[num]

      "part2_rev" ->
        [num | _] = Regex.run(@part2_sigil_rev, s)
        @part2_map[num]
    end
  end

  def getDigit(s) do
    [num | _] = Regex.run(~r/\d/, s)
    num
  end

  def lookupToken(token) do
    @part2_map[token]
  end
end
