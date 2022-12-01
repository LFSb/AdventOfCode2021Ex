defmodule FileUtils do
  def readLinesForDay(day, year) do
    File.read!("lib/inputs/#{year}/day#{day}.txt")
  end

  def readSplitLinesForDay(day, year) do
    readLinesForDay(day, year)
    |> String.split("\n")
  end

  def readSplitLinesAsNumbersForDay(day, year) do
    readSplitLinesForDay(day, year)
    |> Enum.map(&String.to_integer/1)
  end
end
