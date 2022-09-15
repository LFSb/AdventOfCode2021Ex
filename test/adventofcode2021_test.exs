defmodule Adventofcode2021Test do
  use ExUnit.Case
  doctest Adventofcode2021

  test "returns something" do
    testInput = [ 199, 200, 208, 210, 200, 207, 240, 269, 260, 263 ]
    assert Adventofcode2021.day1(testInput) == 7
  end
end
