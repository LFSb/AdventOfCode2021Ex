defmodule FileUtils do
  def readLinesForDay(day) do
    File.read!("lib/inputs/day#{day}.txt")
  end

  def readSplitLinesForDay(day) do
    readLinesForDay(day)
    |> String.split("\n")
  end

  def readSplitLinesAsNumbersForDay(day) do
    readSplitLinesForDay(day)
    |> Enum.map(&String.to_integer/1)
  end
end
