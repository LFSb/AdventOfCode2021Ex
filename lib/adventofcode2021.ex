defmodule Adventofcode2021 do
  import Helpers

  def day1p1(input) do
    input
    |> Enum.with_index()
    |> Enum.count(fn {_val, idx} -> is_value_larger_than_previous_idx(input, idx) end)
  end

  def day1p2(input) do
    input
    |> Enum.with_index()
    |> Enum.count(fn {_val, idx} -> is_window_larger_than_previous_window(input, idx) end)
  end

  def day2p1(input) do
    input
    |> parse_directions
    |> Enum.reduce({0, 0}, fn input, acc -> process_instruction(input, acc) end)
    |> Tuple.product()
  end

  def day2p2(input) do
    input
    |> parse_directions
    |> Enum.reduce({0, 0, 0}, fn input, acc -> aim_sights(input, acc) end)
    |> Tuple.delete_at(2)
    |> Tuple.product()
  end

  def day3p1(input) do
    input
    |> get_column_frequencies
    |> get_power_consumption
  end

  def day3p2(input) do
    input
  end
end
