defmodule AocTest202302 do
  use ExUnit.Case

  # in: "3 blue" => {"blue", 3}
  test "transform score" do
    assert Aoc2302.transform_score("3 blue") == {"blue", 3}
    assert Aoc2302.transform_score("1 green") == {"green", 1}
  end

  # in: [["3 blue", "4 red"], ["1 green", "2 red"]] => {"blue" => 3, "green" => 1, "red" => 6}
  test "transform score rows" do
    assert Aoc2302.transform_score_row(["3 blue", "2 red"]) == %{"blue" => 3, "red" => 2}
  end

  test "bubble score" do
    input = [
      %{"blue" => 3, "red" => 4},
      %{"blue" => 6, "green" => 2, "red" => 1},
      %{"green" => 2}
    ]

    assert Aoc2302.bubble_sort_score(input) == %{"red" => 4, "green" => 2, "blue" => 6}
  end
end
