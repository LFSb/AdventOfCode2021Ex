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
    parseDirections(input)
    |> Enum.reduce({0, 0}, fn input, acc -> processInstruction(input, acc) end)
    |> Tuple.product()
  end

  def day2p2(input) do
    parseDirections(input)
    |> Enum.reduce({0, 0, 0}, fn input, acc -> aimSights(input, acc) end)
    |> Tuple.delete_at(2)
    |> Tuple.product()
  end

  def day3p1(input) do
    # We get a list of maps, containing the individual character frequencies per column. 
    getColumnFrequencies(input)

    # From this, we should create two strings, representing a decimal number in base 2. One that's based on the MSB, and one that's based on the LSB.
  end
end
