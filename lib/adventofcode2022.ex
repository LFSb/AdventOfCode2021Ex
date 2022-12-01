defmodule Adventofcode2022 do
  import Helpers

  def day1p1(input) do
    input
    |> Enum.chunk_by(fn i -> i == "" end)
    |> Enum.reject(fn chunk -> chunk |> List.first == "" end)
    |> Enum.map(fn chunk -> chunk |> Enum.map(&String.to_integer/1) |> Enum.sum end)
    |> Enum.max
  end

  def day1p2(input) do
    input
    |> Enum.chunk_by(fn i -> i == "" end)
    |> Enum.reject(fn chunk -> chunk |> List.first == "" end)
    |> Enum.map(fn chunk -> chunk |> Enum.map(&String.to_integer/1) |> Enum.sum end) 
    |> Enum.sort
    |> Enum.reverse
    |> Enum.take(3)
    |> Enum.sum
  end
end
