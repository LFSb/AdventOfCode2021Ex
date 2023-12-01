defmodule Adventofcode2023Test do
  import FileUtils
  import Helpers
  use ExUnit.Case
  doctest Adventofcode2023

  test "day1p1 testinput" do
    assert readSplitLinesForDay("1test", "2023") |> Adventofcode2023.day1p1() == 142
  end

  test "day1p1 realinput" do
    assert readSplitLinesForDay("1", "2023") |> Adventofcode2023.day1p1() == 54239
  end

  test "day1p2 testinput" do
    assert readSplitLinesForDay("1test2", "2023") |> Adventofcode2023.day1p2() == 281
  end

  test "day1p2 realinput" do
    assert readSplitLinesForDay("1", "2023") |> Adventofcode2023.day1p2() == 55343
  end
end
