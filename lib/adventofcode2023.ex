defmodule Adventofcode2023 do
  def day1p1(input) do
    input
    |> Enum.map(fn line -> line |> String.replace(~r/[^\d]/, "") |> String.split("", trim: true) end)
    |> Enum.map(fn digits -> List.first(digits) <> List.last(digits) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
