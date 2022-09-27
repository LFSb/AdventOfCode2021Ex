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
    input
    |>parseDirections
    |> Enum.reduce({0, 0}, fn input, acc -> processInstruction(input, acc) end)
    |> Tuple.product()
  end

  def day2p2(input) do
    input
    |> parseDirections
    |> Enum.reduce({0, 0, 0}, fn input, acc -> aimSights(input, acc) end)
    |> Tuple.delete_at(2)
    |> Tuple.product()
  end

  def day3p1(input) do
    input
    |> getColumnFrequencies
    |> getPowerConsumption
  end
  
  def day3p2(input) do
    input 
  end
end
