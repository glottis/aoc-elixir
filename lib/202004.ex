defmodule Aoc202004 do

  def input do
    File.read!("./input/202004.in")
    |> String.split("\n\n")
    |> Enum.map(fn line -> String.replace(line, "\n", " ") end)
  end


  def part1 do
    input() |> Enum.map(&transform/1) |> Enum.filter(&valid_map?/1) |> Enum.count()
  end

  def part2 do
    input() |> Enum.map(&transform/1) |> Enum.filter(&valid_map?/1) |> Enum.filter(&valid_map_fields?/1) |> Enum.count()
  end

  def valid_map_fields?(pp_map), do: valid_map_fields?(pp_map, Map.keys(pp_map))
  def valid_map_fields?(_pp_map, []), do: true
  def valid_map_fields?(pp_map, [k | rest]) do

    v = pp_map |> Map.fetch!(k)
    cond do
      k == "byr" && digit_check(k, String.to_integer(v)) -> valid_map_fields?(pp_map, rest)
      k == "iyr" && digit_check(k, String.to_integer(v)) -> valid_map_fields?(pp_map, rest)
      k == "eyr" && digit_check(k, String.to_integer(v)) -> valid_map_fields?(pp_map, rest)
      k == "hgt" && hgt_check(v) -> valid_map_fields?(pp_map, rest)
      k == "hcl" && hcl_check(v) -> valid_map_fields?(pp_map, rest)
      k == "ecl" && ecl_check(v)-> valid_map_fields?(pp_map, rest)
      k == "pid" && pid_check(v)-> valid_map_fields?(pp_map, rest)
      k == "cid" -> valid_map_fields?(pp_map, rest)
      true -> false
    end
  end

  def pid_check(v) do
    String.length(v) == 9
  end

  def ecl_check(v) do
    case v do
      "amb" -> true
      "blu" -> true
      "brn" -> true
      "gry" -> true
      "grn" -> true
      "hzl" -> true
      "oth" -> true
      _ -> false
    end
  end

  def hcl_check(v) do
    String.length(v) == 7 and Regex.match?(~r/^#[0-9]*|[a-f]*$/, v)
  end
  def hgt_check(v) do
    k = v |> String.slice(String.length(v) - 2..-1)
    vv = v |> String.slice(0..String.length(v) - 3) |> String.to_integer()
    case k do
      "cm" -> vv >= 150 && vv <= 193
      "in" -> vv >= 59 && vv <= 76
      _ -> false
    end

  end

  def digit_check("byr", v) do
    v >= 1920 and v <= 2002
  end

  def digit_check("iyr", v) do
    v >= 2010 and v <= 2020
  end

  def digit_check("eyr", v) do
    v >= 2002 and v <= 2030
  end

  def valid_map?(pp_map) do
    case Map.keys(pp_map) |> length do
      8 -> true
      7 -> !Map.has_key?(pp_map, "cid")
      _ -> false
    end
  end

  def transform(x) do
    String.split(x, " ", trim: true) |> Enum.map(fn line ->
        line
        |> String.split(":", trim: true)
      end)
    |> make_map()
  end

  def make_map(x, m \\ %{})
  def make_map([], t), do: t
  def make_map([[x, y] | rest], t) do
    make_map(rest, Map.put(t, x, y))
  end

end
