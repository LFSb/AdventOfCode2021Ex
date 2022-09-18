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

  def parseDirections(input) do
    input
    |> Enum.map(fn i -> String.split(i, " ") end)
    |> Enum.map(fn item -> List.to_tuple(item) end)
  end

  def processInstruction(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> {elem(pos, 0), elem(pos, 1) + distance}
      "up" -> {elem(pos, 0) - distance, elem(pos, 1)}
      "down" -> {elem(pos, 0) + distance, elem(pos, 1)}
      _ -> IO.puts("You fucked up, dumbass")
    end
  end

  def aimSights(input, pos) do
    distance = elem(input, 1) |> String.to_integer()

    case elem(input, 0) do
      "forward" -> {elem(pos, 0) + distance, elem(pos, 1) + elem(pos, 2) * distance, elem(pos, 2)}
      "up" -> {elem(pos, 0), elem(pos, 1), elem(pos, 2) - distance}
      "down" -> {elem(pos, 0), elem(pos, 1), elem(pos, 2) + distance}
      _ -> IO.puts("You fucked up, dumbass.")
    end
  end

  def getColumnWidth(input) do
    input
    |> Enum.fetch!(0)
    |> String.length
  end

  def getColumnFrequencies(input) do
    0..getColumnWidth(input)
    |> Enum.map(fn idx -> input |> Enum.map(fn line -> line |> String.at(idx) end) end)
    |> Enum.map(fn line -> line |> Enum.frequencies() end) # This gives us a 0-indexed list of character freqencies per column of input.
  end

  def convertToBinary(input) do
    input 
    |> Integer.parse(2) 
    |> elem(0)
  end
end
