defmodule Adventofcode2021 do
  use Application
  import Helpers

  def day1(input) do
    input 
    |> Enum.with_index 
    |> Enum.count(fn({_val, idx}) -> comparePrevious(input, idx) == true end)
  end

  def start(_type, _args) do
    input = File.read!("lib/inputs/day1.txt")
            |> String.split("\n")
            |> Enum.map(&String.to_integer/1)
    
    IO.puts(day1(input))
  end
end