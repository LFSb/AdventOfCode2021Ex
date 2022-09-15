defmodule Helpers do
  def safePreviousIdx(i) do
    if(i > 0, do: i - 1, else: i)
  end

  def isValueLargerThanPreviousIdx(input, idx) do
    Enum.at(input, idx) > Enum.at(input, safePreviousIdx(idx))
  end

  def getWindowSum(input, idx) do
    input
    |> Enum.drop(idx)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def isWindowLargerThanPreviousWindow(input, idx) do
    getWindowSum(input, idx) > getWindowSum(input, safePreviousIdx(idx))
  end

  def processInstruction(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> pos = put_elem(pos, 1, elem(pos, 1) + distance)
      "up"      -> pos = put_elem(pos, 0, elem(pos, 0) + distance)
      "down"    -> pos = put_elem(pos, 0, elem(pos, 0) - distance)
      _ -> IO.puts("You fucked up, dumbass")
    end
  end
end
