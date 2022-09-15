defmodule Adventofcode2021Test do
  use ExUnit.Case
  doctest Adventofcode2021

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

  test "day1p1 returns correct answer with testinput" do
    assert readSplitLinesAsNumbersForDay("1test") |> Adventofcode2021.day1p1() == 7
  end

  test "day1p2 returns correct answer with testinput" do
    assert readSplitLinesAsNumbersForDay("1test") |> Adventofcode2021.day1p2() == 5
  end

  test "day1p1 returns correct answer with real input" do
    assert readSplitLinesAsNumbersForDay("1") |> Adventofcode2021.day1p1() == 1616
  end

  test "day1p2 returns correct answer with real input" do
    assert readSplitLinesAsNumbersForDay("1") |> Adventofcode2021.day1p2() == 1645
  end
end
