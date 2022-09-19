defmodule Helpers do
  # Basically, we want n-1, but we don't want -1 as a result.
  def safePreviousIdx(n) do
    if(n > 0, do: n - 1, else: n)
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
    width =
      input
      |> Enum.fetch!(0)
      |> String.length()

    # We're indexing by 0.
    width - 1
  end

  # This gives us a 0-indexed list of character freqencies per column of input.
  def getColumnFrequencies(input) do
    0..getColumnWidth(input)
    |> Enum.map(fn idx -> input |> Enum.map(fn line -> line |> String.at(idx) end) end)
    |> Enum.map(fn line -> line |> Enum.frequencies() end)
  end

  # Here, based on said 0-indexed list of character frequencies we should construct both the gamma and the epsilon rates.
  def getRates(frequencies) do
    inverted = frequencies
    |> Enum.map(fn m -> m |> Map.new(fn {key, val} -> {val, key} end) end) # First, we invert the map for easier sorting.

    gamma = inverted |> Enum.map(fn m -> m |> Enum.max end) |> Enum.map(fn t -> t |> elem(1) end) |> Enum.join |> convertToBinary
    epsilon = inverted |> Enum.map(fn m -> m |> Enum.min end) |> Enum.map(fn t -> t |> elem(1) end) |> Enum.join |> convertToBinary

    gamma * epsilon
  end

  def convertToBinary(input) do
    input
    |> Integer.parse(2)
    |> elem(0)
  end
end
