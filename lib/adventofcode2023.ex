defmodule Adventofcode2023 do
  def day1p1(input) do
    input
    |> Enum.map(fn line -> line |> String.replace(~r/[^\d]/, "") |> String.split("", trim: true) end)
    |> Enum.map(fn digits -> List.first(digits) <> List.last(digits) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def day1p2(input) do
    dict = %{"one" => "o1e", "two" => "t2o", "three" => "t3e", "four" => "f4r", "five" => "f5e", "six" => "s6x", "seven" => "s7n", "eight" => "e8t", "nine" => "n9e"}
    keys = dict |> Map.keys

    input
    |> Enum.map(fn line ->
      keys
      |> Enum.reduce(line, fn key, acc -> String.replace(acc, key, dict[key]) end)
    end)
    |> day1p1
  end
end
