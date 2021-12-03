defmodule Aoc202103 do
  def input do
    File.read!("./input/202103.txt")
    |> String.split("\n", trim: true)
  end

  def part1 do
    gamma_rate = get_binary_rate("gamma", input(), 0)
    epilson_rate = get_binary_rate("epilson", input(), 0)
    calc(gamma_rate, epilson_rate)
  end

  def part2 do
    oxygen = input() |> oxygen_scrub_rate("oxygen")
    scrub = input() |> oxygen_scrub_rate("scrub")
    calc(oxygen, scrub)
  end

  def group_by_max(type, x) do
    case type do
      "epilson" -> x |> Enum.frequencies() |> Enum.min_by(fn {_x, y} -> y end)
      "gamma" -> x |> Enum.frequencies() |> Enum.max_by(fn {_x, y} -> y end)
      _ -> Exception.message("Wrong binary rate requested")
    end
  end

  def get_binary_rate(_type, _x, rounds, gr, _org) when rounds == 12, do: gr.acc

  def get_binary_rate(type, [], rounds, gr, org) do
    {key, _count} = group_by_max(type, gr.tmp)
    get_binary_rate(type, org, rounds + 1, %{tmp: [], acc: gr.acc <> key}, org)
  end

  def get_binary_rate(type, [h | t], rounds, gr \\ %{tmp: [], acc: ""}, org \\ []) do
    org =
      case org do
        [] -> [h | t]
        _ -> org
      end

    b = h |> String.at(rounds)

    get_binary_rate(type, t, rounds, %{tmp: [b | gr.tmp], acc: gr.acc}, org)
  end

  def oxygen_scrub_rate(x, type) do
    case type do
      "oxygen" -> oxygen_scrub_rate(x, 0, &Enum.reverse/1, &Enum.max_by/2)
      "scrub" -> oxygen_scrub_rate(x, 0, &Enum.sort/1, &Enum.min_by/2)
    end
  end

  def oxygen_scrub_rate([x], _rounds, _sort_func, _filter_func), do: x

  def oxygen_scrub_rate(list, rounds, sort_fn, filter_fn) do
    extended_keys = list |> Enum.map(fn x -> {String.at(x, rounds), x} end)

    {wanted_key, _val} =
      extended_keys
      |> Enum.map(fn {x, _y} -> x end)
      |> Enum.frequencies()
      |> sort_fn.()
      |> filter_fn.(fn {_k, v} -> v end)

    adjusted_list =
      extended_keys
      |> Enum.filter(fn {k, _v} -> wanted_key == k end)
      |> Enum.map(fn {_k, v} -> v end)

    oxygen_scrub_rate(adjusted_list, rounds + 1, sort_fn, filter_fn)
  end

  def calc(x, y) do
    {x_val, _y} = x |> Integer.parse(2)
    {y_val, _y} = y |> Integer.parse(2)

    IO.puts(x_val * y_val)
  end
end
