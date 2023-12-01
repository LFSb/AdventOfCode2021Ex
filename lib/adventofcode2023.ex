defmodule Adventofcode2023 do
  def day1p1(input) do
    input
    |> Enum.map(fn line -> line |> String.replace(~r/[^\d]/, "") |> String.split("", trim: true) end)
    |> Enum.map(fn digits -> List.first(digits) <> List.last(digits) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def day1p2(input) do
    words = %{"one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9"}
    numbers = Map.new(words, fn {key, val} -> {val, key} end)
    dict = Map.merge(words, numbers)
    keys = dict |> Map.keys

    input
    |> Enum.map(fn line ->
      keys
      |> Enum.filter(fn key -> String.contains?(line, key) end)
      |> Enum.sort_by(fn occ -> String.split(line, occ) |> List.first() |> String.length end)
    end)
    |> Enum.map(fn line ->
      line
      |> Enum.map(fn el -> if Map.has_key?(words, el), do: words[el], else: el end)
    end)
    |> Enum.map(fn digits -> List.first(digits) <> List.last(digits) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
