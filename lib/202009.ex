defmodule Aoc202009 do

  def input() do
    File.read!("./input/202009.in")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def part1 do
    input()
    |> fetch_next(25)
  end

  def part2 do
    input()
    |> find_set(167829540)
    |> find_min_max()
  end

  def fetch_next(x, n), do: fetch_next(x, 0, n)
  def fetch_next(x, start, n) when start + n >= length(x), do: :error_miss
  def fetch_next(x, start, n) do
    nums = Enum.slice(x, start, n)
    next = Enum.fetch!(x, start + n)
    case check_num(nums, next) do
      false -> {:no_match, next}
      true -> fetch_next(x, start + 1, n)
    end
  end

  defp check_num([], _t), do: false
  defp check_num([x | rest], t) do
    res = Enum.count(rest, fn y -> y + x == t end)
    case res do
      0 -> check_num(rest, t)
      _ -> true
    end
  end


  def find_min_max(x), do: Enum.min(x) + Enum.max(x)
  def find_set(x, target), do: find_set(x, x, target, 0, [], 0)
  def find_set([], _target, _acc, _s), do: :error_miss
  def find_set([h | t], m, target, acc, acc_list, start) do
    cond do
      h + acc == target && length(acc_list) > 0 -> [h | acc_list]
      h + acc < target -> find_set(t, m, target, acc + h, [h | acc_list], start)
      h + acc > target -> restart_at(m, start) |> find_set(m, target, 0, [], start + 1)
    end
  end

  defp restart_at(m, start) do
    Enum.slice(m, start + 1, length(m) - 1 - start + 1)
  end

end
