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
end