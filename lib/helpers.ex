defmodule Helpers do
    def previousIdx(i) do if(i > 0, do: i - 1, else: i) end
  
    def comparePrevious(inputList, idx) do Enum.at(inputList, idx) > Enum.at(inputList, previousIdx(idx)) end
end