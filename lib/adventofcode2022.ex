defmodule Adventofcode2022 do
  import Helpers

  def day1p1(input) do
    input
    |> Helpers.chunk_by_empty()
    |> Enum.map(fn chunk -> chunk |> Enum.map(&String.to_integer/1) |> Enum.sum() end)
    |> Enum.max()
  end

  def day1p2(input) do
    input
    |> Helpers.chunk_by_empty()
    |> Enum.map(fn chunk -> chunk |> Enum.map(&String.to_integer/1) |> Enum.sum() end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  def day2p1(input) do
    input
    |> Enum.map(fn x -> x |> String.split(" ") |> List.to_tuple() end)
    |> Enum.map(fn x -> calculate_round_result(elem(x, 0), elem(x, 1)) end)
    |> Enum.sum()
  end

  def day2p2(input) do
    input
    |> Enum.map(fn x -> x |> String.split(" ") |> List.to_tuple() end)
    |> Enum.map(fn x -> calculate_desired_round_result(elem(x, 0), elem(x, 1)) end)
    |> Enum.sum()
  end

  def day3p1(input) do
    input 
    |> Enum.map(fn x -> 
      x 
      |> String.graphemes 
      |> Enum.chunk_every(x |> get_half_length) 
      |> Enum.map(fn y -> 
        y 
        |> Enum.uniq 
        |> MapSet.new() end) 
      |> intersect
      |> MapSet.to_list
      |> Enum.at(0)
      |> convert_to_priority
      end) 
    |> Enum.sum()
  end
end
