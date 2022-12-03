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

  test "day2p1 results line up with expectation" do
    assert calculate_round_result("A", "Y") == 8
  end

  test "day2p1 testinput" do
    assert readSplitLinesForDay("2test", "2022") |> Adventofcode2022.day2p1() == 15
  end

  test "day2p1 realinput" do
    assert readSplitLinesForDay("2", "2022") |> Adventofcode2022.day2p1() == 11386
  end

  test "day2p2 results line up with expectation" do
    assert calculate_desired_round_result("A", "Y") == 4
  end

  test "day2p2 testinput" do
    assert readSplitLinesForDay("2test", "2022") |> Adventofcode2022.day2p2() == 12
  end

  test "day2p2 realinput" do
    assert readSplitLinesForDay("2", "2022") |> Adventofcode2022.day2p2() == 13600
  end

  test "string to int conversion for day3 #1" do
    assert ("a" |> convert_to_priority) + ("A" |> convert_to_priority) == 28
  end

  test "string to int conversion for day3 #2" do
    assert ("z" |> convert_to_priority) + ("Z" |> convert_to_priority) == 78
  end

  test "day3p1 testinput" do
    assert readSplitLinesForDay("3test", "2022") |> Adventofcode2022.day3p1() == 157
  end

  test "day3p1 realinput" do
    assert readSplitLinesForDay("3", "2022") |> Adventofcode2022.day3p1() == 7889
  end

  test "day3p2 testinput" do
    assert readSplitLinesForDay("3test", "2022") |> Adventofcode2022.day3p2() == 70
  end

  test "day3p2 realinput" do
    assert readSplitLinesForDay("3", "2022") |> Adventofcode2022.day3p2() == 2825
  end
end
