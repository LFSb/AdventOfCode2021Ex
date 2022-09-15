defmodule Adventofcode2021 do
  import Helpers

  def day1p1(input) do
    input
    |> Enum.with_index()
    |> Enum.count(fn {_val, idx} -> isValueLargerThanPreviousIdx(input, idx) end)
  end

  def day1p2(input) do
    input
    |> Enum.with_index()
    |> Enum.count(fn {_val, idx} -> isWindowLargerThanPreviousWindow(input, idx) end)
  end

  def day2p1(input) do
    tup = input
    |> Enum.map(fn i -> String.split(i, " ") end)
    |> Enum.map(fn item -> List.to_tuple(item) end)
    |> Enum.each(fn (instruction) -> processInstruction(instruction, {0, 0}) end)

    IO.puts(tup)
  end
end
