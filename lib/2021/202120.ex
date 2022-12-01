defmodule Aoc202120 do
  def input do
    [alg | data] =
      File.read!("./input/202120.txt")
      |> String.split("\n", trim: true)

    first = data |> List.first()
    padding = generate_padding(String.length(first))

    padded = add_padding(padding, data)

    [alg | padded]
  end

  defp add_padding(padding, list) do
    ([padding] ++ [padding] ++ [padding] ++ list ++ [padding] ++ [padding] ++ [padding])
    |> Enum.map(fn x -> padding <> x <> padding end)
  end

  defp generate_padding(0, result), do: result

  defp generate_padding(len, result \\ "") do
    generate_padding(len - 1, result <> ".")
  end

  def part1 do
    [alg | data] = input
    fixed_alg = alg |> fix_algorithm
    image = fix_input_data(data) |> construct_map

    first = enhance_image(image, fixed_alg)
    second = enhance_image(first, fixed_alg)

    Enum.filter(second, fn {{_x, _y}, k} -> k == "#" end) |> Enum.count()
  end

  def fetch_data({x, y}, map) do
    data = [
      map[{x - 1, y - 1}],
      map[{x, y - 1}],
      map[{x + 1, y - 1}],
      map[{x - 1, y}],
      map[{x, y}],
      map[{x + 1, y}],
      map[{x - 1, y + 1}],
      map[{x, y + 1}],
      map[{x + 1, y + 1}]
    ]

    raw =
      data
      |> Enum.map(fn x ->
        case x do
          nil -> "."
          _ -> x
        end
      end)
      |> Enum.map(fn x ->
        case x do
          "." -> "0"
          "#" -> "1"
        end
      end)
      |> Enum.reduce("", fn x, acc -> acc <> x end)

    Integer.parse(raw, 2)
  end

  def enhance_image(image, algo) do
    new_image = image

    image
    |> Enum.reduce(new_image, fn {{x, y}, _v}, acc ->
      {data_value, _} = fetch_data({x, y}, image)
      corrected = algo[data_value]
      Map.replace(acc, {x, y}, corrected)
    end)
  end

  def fix_algorithm(algo, fixed \\ %{}) do
    algo
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(fixed, fn {v, k}, acc -> Map.put(acc, k, v) end)
  end

  def construct_map([], result), do: result
  def construct_map([{[], _} | t], result), do: construct_map(t, result)

  def construct_map([{[{v, x} | tt], y} | t], result \\ %{}) do
    new_result = Map.put(result, {x, y}, v)
    construct_map([{tt, y} | t], new_result)
  end

  def fix_input_data(data) do
    Enum.with_index(data)
    |> Enum.map(fn {x, y} ->
      {String.graphemes(x) |> Enum.with_index(), y}
    end)
  end
end
