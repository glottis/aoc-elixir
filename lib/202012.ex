defmodule Aoc202012 do

  def input do
    File.read!("./input/202012.in")
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split_at(&1, 1)))
    |> Enum.map(fn {x, y} -> {x, y |> String.to_integer(10)} end)
  end

  def part_1 do
    input()
    |> traverse({{0,0}, "E"})
    |> calc()
  end

  def part_2 do
    input()
    |> traverse_p2({{0,0}, {10,1}}) # ship pos, waypoint
    |> IO.inspect()
    |> calc()
  end

  def traverse([], m), do: m
  def traverse([h | t], m) do
    traverse(t, update_course(h, m))
  end

  def traverse_p2([], m), do: m
  def traverse_p2([h | t], m) do
    IO.inspect(m)
    traverse_p2(t, update_course_redux(h, m))
  end

  def update_course({"R", 0}, {pos, f}), do: {pos, f}
  def update_course({"L", 0}, {pos, f}), do: {pos, f}

  def update_course({dir, v}, {pos, f}) when dir == "R" or dir == "L" do
    case dir do
      "R" ->
        case f do
          "N" -> update_course({dir, v - 90}, {pos, "E"})
          "E" -> update_course({dir, v - 90}, {pos, "S"})
          "S" -> update_course({dir, v - 90}, {pos, "W"})
          "W" -> update_course({dir, v - 90}, {pos, "N"})
        end
      "L" ->
        case f do
          "N" -> update_course({dir, v - 90}, {pos, "W"})
          "E" -> update_course({dir, v - 90}, {pos, "N"})
          "S" -> update_course({dir, v - 90}, {pos, "E"})
          "W" -> update_course({dir, v - 90}, {pos, "S"})
        end
    end

  end

  def update_course({dir, v}, {{x,y}, f}) do
    case dir do
      "F" -> update_course({f, v}, {{x,y}, f})
      "N" -> {{x, y + v}, f}
      "E" -> {{x + v, y}, f}
      "S" -> {{x, y - v}, f}
      "W" -> {{x - v, y}, f}
    end
  end

  def update_course_redux({"R", 0}, {pos, wp}), do: {pos, wp}
  def update_course_redux({"L", 0}, {pos, wp}), do: {pos, wp}

  def update_course_redux({dir, v}, {pos, {x,y}}) when dir == "R" or dir == "L" do
    case dir do
      "R" ->
          update_course_redux({dir, v - 90}, {pos, {y, -x}})
      "L" ->
          update_course_redux({dir, v - 90}, {pos, {-y, x}})
    end

  end

  def update_course_redux({dir, v}, {{x,y}, {wp_x, wp_y}}) do
    case dir do
      "F" -> {{x + (wp_x * v) ,y + (wp_y * v)}, {wp_x, wp_y}}
      "N" -> {{x, y}, {wp_x, wp_y + v}}
      "E" -> {{x, y}, {wp_x + v, wp_y}}
      "S" -> {{x, y}, {wp_x, wp_y - v}}
      "W" -> {{x, y}, {wp_x - x, wp_y}}
    end
  end

  def calc({{x,y}, _}) do
    Kernel.abs(x) + Kernel.abs(y)
  end

end
