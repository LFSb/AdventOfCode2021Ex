defmodule Helpers do
  def previousIdx(i) do
    if(i > 0, do: i - 1, else: i)
  end

  def isValueLargerThanPreviousIdx(input, idx) do
    Enum.at(input, idx) > Enum.at(input, previousIdx(idx))
  end

  def getWindowSum(input, idx) do
    input
    |> Enum.drop(idx)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def isWindowLargerThanPreviousWindow(input, idx) do
    getWindowSum(input, idx) > getWindowSum(input, previousIdx(idx))
  end
end
