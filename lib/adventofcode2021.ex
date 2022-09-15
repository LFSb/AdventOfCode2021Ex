defmodule Adventofcode2021 do
  import Helpers

  def day1p1(input) do
    input
    |> Enum.with_index()
    |> Enum.count(fn {_val, idx} -> isValueLargerThanPreviousIdx(input, idx) == true end)
  end

  def day1p2(input) do
    input
    |> Enum.with_index()
    |> Enum.count(fn {_val, idx} -> isWindowLargerThanPreviousWindow(input, idx) == true end)
  end
end
