defmodule Aoc202008 do
  defstruct [:op, :sign, :n, visited: 0]

def input do
  File.read!("./input/202008.in")
  |> String.split("\n")
  |> Enum.map(fn l ->
   [op, sn] = String.split(l, " ")
   {sign, n} = sn |> String.split_at(1)
   %Aoc202008{op: op, sign: sign, n: n |> String.to_integer}
  end)
end

def part1 do
  input()
  |> traverse
end

def part2 do
  input()
  |> each_for_traverse
end

def traverse(x, index \\ 0, acc \\ 0)
def traverse(x, index, acc) when index == length(x), do: {:correct, acc} # part2 endgame
def traverse(x, index, acc) do

  case t = Enum.fetch!(x, index) do
    %{visited: n} when n > 0 -> {:seen, acc}
    %{op: "nop"}            -> upd_list(x, index, "v") |> traverse(index + 1, acc)
    %{op: "acc", sign: "+"} -> upd_list(x, index, "v") |> traverse(index + 1, acc + t.n)
    %{op: "acc", sign: "-"} -> upd_list(x, index, "v") |> traverse(index + 1, acc - t.n)
    %{op: "jmp", sign: "+"} -> upd_list(x, index, "v") |> traverse(index + t.n, acc)
    %{op: "jmp", sign: "-"} -> upd_list(x, index, "v") |> traverse(index - t.n, acc)
    end
end

defp upd_list(x, index, func) do

  case func do
    "v" -> List.update_at(x, index, fn x -> %{x | visited: x.visited + 1} end)
    "nop" -> List.update_at(x, index, fn x -> %{x | op: "jmp"} end)
    "jmp" -> List.update_at(x, index, fn x -> %{x | op: "nop"} end)
  end
end

def each_for_traverse(x), do: each_for_traverse(x, x, 0)
def each_for_traverse([], _m, _index), do: :error_no_match
def each_for_traverse([%{op: op} | rest], m, index) when op == "nop" or op == "jmp" do

  new = upd_list(m, index, op)
  case traverse(new) do
    {:correct, acc} -> acc
    {:seen, _acc} ->
      each_for_traverse(rest, m, index + 1)
  end
end

def each_for_traverse([_x | rest], m, index), do: each_for_traverse(rest, m, index + 1)

end
