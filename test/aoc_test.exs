defmodule AocTest do
  use ExUnit.Case

  test "201901p1" do
    assert Aoc201901.calcFuel(12) == 2
    assert Aoc201901.calcFuel(14) == 2
    assert Aoc201901.calcFuel(1969) == 654
    assert Aoc201901.calcFuel(100756) == 33583
    assert Aoc201901.calcFuel(1) == 0
  end

  test "201901p2" do
    assert Aoc201901.calcFuelv2(14) == 2
    assert Aoc201901.calcFuelv2(1969) == 966
    assert Aoc201901.calcFuelv2(100756) == 50346
  end

  test "AocIntcode" do
    assert AocIntcode.processPrg([1,0,0,0,99]) == [2,0,0,0,99]
    assert AocIntcode.processPrg([2,3,0,3,99]) == [2,3,0,6,99]
    assert AocIntcode.processPrg([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    assert AocIntcode.processPrg([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
  end

  test "Aoc202002" do
    x = ["1-3 a: abcde",
    "1-3 b: cdefg",
    "2-9 c: ccccccccc"]

    assert x |> Aoc202002.fixInput() |> Enum.filter(&Aoc202002.matches_rule?/1) |> Enum.count == 2

  end

end
