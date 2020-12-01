defmodule AocIntcode do
  @opcode_add 1
  @opcode_mult 2
  @opcode_save 3
  @opcode_load 4
  @opcode_halt 99

  def processPrg(pgr, ptr \\ 0, input \\ nil) do

    case Enum.at(pgr, ptr) do

      @opcode_add ->
        [_i, x, y, reg] = Enum.slice(pgr, ptr, 4)
        res = Enum.fetch!(pgr, x) + Enum.fetch!(pgr, y)
        List.replace_at(pgr, reg, res) |> processPrg(ptr + 4)

      @opcode_halt ->
        :halt

      @opcode_mult ->
        [_i, x, y, reg] = Enum.slice(pgr, ptr, 4)
        res = Enum.fetch!(pgr, x) * Enum.fetch!(pgr, y)
        List.replace_at(pgr, reg, res) |> processPrg(ptr + 4)

      @opcode_save when input != nil ->
        reg = Enum.at(pgr, ptr + 1)
        List.replace_at(pgr, reg, input) |> processPrg(ptr + 2)

      @opcode_load ->
        reg = Enum.at(pgr, ptr + 1)
        IO.inspect({:output, Enum.fetch!(pgr, reg)})
        processPrg(pgr, ptr + 2)

      op ->
        case op |> Integer.digits |> Enum.reverse() do
          [_a,_b, c, d, e] ->
            if c == 1, do: Enum.fetch!(pgr, ptr + 1)
            if d == 1, do: :application
            if e == 1, do: :e
          [_a,_b, c, d] ->
            if c == 1, do: :e
            if d == 1, do: :application
          [_a,_b, c] -> :e
            if c == 1, do: :e
          end
    end

    # case Enum.slice(program, ptr, 4) do
    #   [@opcode_add, x, y, reg] ->
    #     res = Enum.fetch!(program, x) + Enum.fetch!(program, y)
    #     List.replace_at(program, reg, res) |> processPrg(ptr + 4)
    #   [............]
    # end

  end

end
