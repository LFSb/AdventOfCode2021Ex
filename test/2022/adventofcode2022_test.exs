defmodule Adventofcode2022Test do
  import FileUtils
  import Helpers
  use ExUnit.Case
  doctest Adventofcode2022

  test "day1p1 testinput" do
    assert readSplitLinesForDay("1test", "2022") |> Adventofcode2022.day1p1() == 24000
  end

  test "day1p1 realinput" do
    assert readSplitLinesForDay("1", "2022") |> Adventofcode2022.day1p1() == 68923
  end

  test "day1p2 testinput" do
    assert readSplitLinesForDay("1test", "2022") |> Adventofcode2022.day1p2() == 45000
  end

  test "day1p2 realinput" do
    assert readSplitLinesForDay("1", "2022") |> Adventofcode2022.day1p2() == 200_044
  end

  test "day2p1 results" do
    assert calculate_round_result("A", "Y") == 8
  end

  test "day2p1 testinput" do
    assert readSplitLinesForDay("2test", "2022") |> Adventofcode2022.day2p1() == 15
  end

  test "day2p1 realinput" do
    assert readSplitLinesForDay("2", "2022") |> Adventofcode2022.day2p1() == 11386
  end

  test "day2p2 testinput" do
    assert readSplitLinesForDay("2test", "2022") |> Adventofcode2022.day2p2() == 12 
  end

  test "day2p2 realinput" do
    assert readSplitLinesForDay("2", "2022") |> Adventofcode2022.day2p2() == 12 
  end
end