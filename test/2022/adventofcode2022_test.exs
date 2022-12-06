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

  test "day4p1 testinput" do
    assert readSplitLinesForDay("4test", "2022") |> Adventofcode2022.day4p1() == 2
  end

  test "day4p1 realinput" do
    assert readSplitLinesForDay("4", "2022") |> Adventofcode2022.day4p1() == 518
  end

  test "day4p2 testinput" do
    assert readSplitLinesForDay("4test", "2022") |> Adventofcode2022.day4p2() == 4
  end

  test "day4p2 realinput" do
    assert readSplitLinesForDay("4", "2022") |> Adventofcode2022.day4p2() == 909
  end

  test "day5p1 test tower input" do
    assert ["    [D]    ", "[N] [C]    ", "[Z] [M] [P]", " 1   2   3 "]
           |> build_tower
           |> Enum.at(0) == {"Z", "N", " "}
  end

  test "day5p1 test input" do
    assert readSplitLinesForDay("5test", "2022") |> Adventofcode2022.day5p1() == "CMZ"
  end

  test "day5p1 real input" do
    assert readSplitLinesForDay("5", "2022") |> Adventofcode2022.day5p1() == ""
  end

  test "day6p1 testinput #1" do
    assert "mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> Adventofcode2022.day6p1() == 7
  end

  test "day6p1 testinput #2" do
    assert "bvwbjplbgvbhsrlpgdmjqwftvncz" |> Adventofcode2022.day6p1() == 5
  end

  test "day6p1 testinput #3" do
    assert "nppdvjthqldpwncqszvftbrmjlhg" |> Adventofcode2022.day6p1() == 6
  end

  test "day6p1 testinput #4" do
    assert "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" |> Adventofcode2022.day6p1() == 10
  end

  test "day6p1 testinput #5" do
    assert "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" |> Adventofcode2022.day6p1() == 11
  end

  test "day6p1 realinput" do
    assert readLinesForDay("6", "2022") |> Adventofcode2022.day6p1() == 1210
  end

  test "day6p2 testinput #1" do
    assert "mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> Adventofcode2022.day6p2() == 19
  end

  test "day6p2 realinput" do
    assert readLinesForDay("6", "2022") |> Adventofcode2022.day6p2() == 3476
  end
end
