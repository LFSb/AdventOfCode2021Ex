defmodule Adventofcode2021 do
  def day1(input) do
    
    safePrevious = fn(i) -> if(i > 0, do: i - 1, else: i) end
    comparePrevious = fn(inputList, idx) -> Enum.at(inputList, idx) > Enum.at(inputList, safePrevious.(idx)) end

    input 
    |> Enum.with_index 
    |> Enum.each(fn({val, idx}) -> if(comparePrevious.(input, idx), do: IO.puts("Yay!")) end)
      #IO.puts("#{Enum.at(input, idx)} > #{Enum.at(input, safePrevious.(idx))}:#{comparePrevious.(input, idx)}") end)
      #Ok, so this almost works, but I cannot change the value of a variable outside of its scope, so I'll need to calculate the result inside the function.
    day1
  end
end