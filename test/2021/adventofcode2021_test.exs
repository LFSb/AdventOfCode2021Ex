defmodule Adventofcode2021Test do
  import FileUtils
  import Helpers
  use ExUnit.Case
  doctest Adventofcode2021

  test "day1p1 testinput" do
    assert readSplitLinesAsNumbersForDay("1test", "2021") |> Adventofcode2021.day1p1() == 7
  end

  test "day1p2 testinput" do
    assert readSplitLinesAsNumbersForDay("1test", "2021") |> Adventofcode2021.day1p2() == 5
  end

  test "day1p1 realinput" do
    assert readSplitLinesAsNumbersForDay("1", "2021") |> Adventofcode2021.day1p1() == 1616
  end

  test "day1p2 realinput" do
    assert readSplitLinesAsNumbersForDay("1", "2021") |> Adventofcode2021.day1p2() == 1645
  end

  test "day2p1 testinput" do
    assert readSplitLinesForDay("2test", "2021") |> Adventofcode2021.day2p1() == 150
  end

  test "day2p1 realinput" do
    assert readSplitLinesForDay("2", "2021") |> Adventofcode2021.day2p1() == 2_039_256
  end

  test "day2p2 testinput" do
    assert readSplitLinesForDay("2test", "2021") |> Adventofcode2021.day2p2() == 900
  end

  test "day2p2 realinput" do
    assert readSplitLinesForDay("2", "2021") |> Adventofcode2021.day2p2() == 1_856_459_736
  end

  test "day3p1 testinput" do
    assert readSplitLinesForDay("3test", "2021") |> Adventofcode2021.day3p1() == 198
  end

  test "day3p1 realinput" do
    assert readSplitLinesForDay("3", "2021") |> Adventofcode2021.day3p1() == 2_498_354
  end

  # test "day3p2 testinput" do
  #   assert readSplitLinesForDay("3test") |> Adventofcode2021.day3p2() == 230
  # end

  test "day3p2 partial test msb true" do
    msb = true
    input = readSplitLinesForDay("3test", "2021") |> filterInputByIndex(msb)
    assert input |> filterInputByIndex(msb) == ["10110", "10111", "10101", "10000"]
  end

  test "day3p2 partial test #2" do
    msb = false
    input = readSplitLinesForDay("3test", "2021") |> filterInputByIndex(msb)
    assert input |> filterInputByIndex(msb) == ["01111", "01010"]
  end
end
